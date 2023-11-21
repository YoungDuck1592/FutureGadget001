//
//  SignUpPageView.swift
//  Memo
//
//  Created by 서영덕 on 11/17/23.
//

import UIKit
import SnapKit
import Then

class SignUpPageView: UIView {
    // UI 요소 정의
    let welcomeLabel = UILabel()
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let rePasswordTextField = UITextField()
    let signUpButton = UIButton()
    var usernameContainerView = UIView()
    var emailContainerView = UIView()
    var passwordContainerView = UIView()
    var rePasswordContainerView = UIView()

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
            $0.text = "Create Account"
            $0.font = UIFont(name: "GangwonEduAll", size: 36)
            $0.textAlignment = .center
        })
        
        // 사용자 이름 입력창 컨테이너 뷰 설정
        let userImage = UIImage(named: "User") ?? UIImage(named: "Error")!
        usernameContainerView = usernameTextField.inputContainerView(withImage: userImage, textField: usernameTextField.then {
            $0.placeholder = "Username"
            $0.borderStyle = .none
        })
        addSubview(usernameContainerView)

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
        
        // 비밀번호 재입력창 컨테이너 뷰 설정
        let reLockImage = UIImage(named: "Lock") ?? UIImage(named: "Error")!
        rePasswordContainerView = rePasswordTextField.inputContainerView(withImage: reLockImage, textField: rePasswordTextField.then {
            $0.placeholder = "Password Confirm"
            $0.borderStyle = .none
            $0.isSecureTextEntry = true
        })
        addSubview(rePasswordContainerView)

        // 회원가입 버튼 설정
        addSubview(signUpButton.then {
            $0.setTitle("Sign Up!", for: .normal)
            $0.backgroundColor = UIColor.clear
            $0.titleLabel?.font = UIFont(name: "GangwonEduAll", size: 26)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.setTitleColor(UIColor.white, for: .highlighted)
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

        // UsernameContainerView 레이아웃 설정
        usernameContainerView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        // EmailContainerView 레이아웃 설정
        emailContainerView.snp.makeConstraints { make in
            make.top.equalTo(usernameContainerView.snp.bottom).offset(20)
            make.left.right.equalTo(usernameContainerView)
            make.height.equalTo(50)
        }

        // PasswordContainerView 레이아웃 설정
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(emailContainerView.snp.bottom).offset(20)
            make.left.right.equalTo(emailContainerView)
            make.height.equalTo(50)
        }
        
        // RePasswordContainerView 레이아웃 설정
        rePasswordContainerView.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom).offset(20)
            make.left.right.equalTo(passwordContainerView)
            make.height.equalTo(50)
        }

        // SignUpButton 레이아웃 재조정
        signUpButton.snp.remakeConstraints { make in
            make.top.equalTo(rePasswordContainerView.snp.bottom).offset(60)
            make.left.right.equalTo(rePasswordContainerView)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }
}
