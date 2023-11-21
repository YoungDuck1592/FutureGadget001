//
//  LoginPageVC.swift
//  Memo
//
//  Created by 서영덕 on 11/13/23.
//

import UIKit

class LoginPageVC: UIViewController {
    private var loginView: LoginPageView {
        return view as! LoginPageView
    }
    
    var viewModel: LoginPageVM!
    
    override func loadView() {
        view = LoginPageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginPageVM()
        setupButtonActions()

    }
    
    private func setupButtonActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        let writingPageVC = WritingPageVC()
        navigationController?.pushViewController(writingPageVC, animated: true)
    }
    
    @objc private func signUpButtonTapped() {
        let signUpPageVC = SignUpPageVC()
        navigationController?.pushViewController(signUpPageVC, animated: true)
    }
}
