//
//  LoginPageView.swift
//  Memo
//
//  Created by 서영덕 on 11/13/23.
//

import UIKit
import SnapKit
import Then

class LoginPageView: UIView {

    let welcomeLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signUpPromptLabel = UILabel()
    let signUpButton = UIButton()
    var emailContainerView = UIView()
    var passwordContainerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // 배경색 설정
        backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        
        // Welcome 라벨 설정
        addSubview(welcomeLabel.then {
            $0.text = "Welcome!"
            $0.font = UIFont(name: "GangwonEduAll", size: 36)
            $0.textAlignment = .center
        })
        
        // 이메일 입력창 컨테이너 뷰 설정
        let mailImage = UIImage(named: "Mail") ?? UIImage(named: "Error")!
        emailContainerView = emailTextField.inputContainerView(withImage: mailImage, textField: emailTextField.then {
            $0.placeholder = "Email"
            $0.borderStyle = .none
        })
        addSubview(emailContainerView)

        // 비밀번호 입력창 컨테이너 뷰 설정
        let lockImage = UIImage(named: "Lock") ?? UIImage(named: "Error")!
        passwordContainerView = passwordTextField.inputContainerView(withImage: lockImage, textField: passwordTextField.then {
            $0.placeholder = "Password"
            $0.borderStyle = .none
            $0.isSecureTextEntry = true
        })
        addSubview(passwordContainerView)

        
        // 로그인 버튼 설정
        addSubview(loginButton.then {
            $0.setTitle("Login", for: .normal)
            $0.backgroundColor = UIColor.clear
            $0.titleLabel?.font = UIFont(name: "GangwonEduAll", size: 26)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.setTitleColor(UIColor.white, for: .highlighted)
        })

        // 이메일 가입 버튼 설정
        addSubview(signUpButton.then {
            $0.setTitle("Sign Up!", for: .normal)
            $0.backgroundColor = UIColor.clear
            $0.titleLabel?.font = UIFont(name: "GangwonEduAll", size: 26)
            $0.setTitleColor(UIColor.blue, for: .normal)
            $0.setTitleColor(UIColor.white, for: .highlighted)
        })

        // "Don't have an account?" 라벨 설정
        addSubview(signUpPromptLabel.then {
            $0.text = "Don’t have an account?"
            $0.font = UIFont(name: "GangwonEduAll", size: 20)
            $0.textColor = .gray
            $0.textAlignment = .center
        })
        
        // Auto Layout 설정
        setupAutoLayout()
    }
    
    
    private func setupAutoLayout() {
        
        // WelcomeLabel 레이아웃 설정
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        // EmailContainerView 레이아웃 설정
        emailContainerView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        // PasswordContainerView 레이아웃 설정
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(emailContainerView.snp.bottom).offset(20)
            make.left.right.equalTo(emailContainerView)
            make.height.equalTo(50)
        }
        
        // LoginButton 레이아웃 설정
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom).offset(60)
            make.left.right.equalTo(passwordContainerView)
            make.height.equalTo(50)
        }
        
        // SignUpPromptLabel 레이아웃 설정
        signUpPromptLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(40)
            make.left.right.equalTo(loginButton)
            make.bottom.equalTo(signUpButton.snp.top).offset(0)
        }
        
        // SignUpButton 레이아웃 설정
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signUpPromptLabel.snp.bottom).offset(10)
            make.left.right.equalTo(loginButton)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }
}
