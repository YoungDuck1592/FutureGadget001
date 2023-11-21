//
//  SignUpPageVC.swift
//  Memo
//
//  Created by 서영덕 on 11/17/23.
//

import Foundation
import UIKit

class SignUpPageVC: UIViewController {
    private var signUpView: SignUpPageView {
        return view as! SignUpPageView
    }

    override func loadView() {
        view = SignUpPageView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // signUpView의 UI 요소에 대한 추가 설정
        // 예: 버튼 액션 추가, 스타일 조정 등
    }

    // 필요한 경우 추가 메소드 구현
}
