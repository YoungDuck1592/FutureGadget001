//
//  WritingPageVC.swift
//  Memo
//
//  Created by 서영덕 on 11/14/23.
//

import UIKit
import SnapKit
import Then


class WritingPageVC: UIViewController {
    
    var viewModel: WritingPageVM!
    var writingPageView: WritingPageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WritingPageVM()
        setupView()
        setupActions()
        setupBindings()
        registerForKeyboardNotifications()
    }
    
    deinit {
        // 키보드 알림 제거
        NotificationCenter.default.removeObserver(self)
    }

    private func setupView() {
        writingPageView = WritingPageView()
        view.addSubview(writingPageView)
        writingPageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupActions() {
        
        writingPageView.imagePickerButton.addTarget(self, action: #selector(imagePickerButtonTapped), for: .touchUpInside)
        
        writingPageView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    private func setupBindings() {
        // ViewModel과 WritingPageView 사이의 바인딩을 설정
        // 텍스트 뷰의 텍스트를 뷰 모델의 프로퍼티에 바인딩할 수 있습니다.
        // 또한 버튼 탭과 같은 액션을 처리할 수 있습니다.
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            writingPageView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        writingPageView.contentInset = .zero
    }
    
}

// MARK: - UITextViewDelegate
extension WritingPageVC: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.isFirstResponder {
            var cursorRect = textView.caretRect(for: textView.selectedTextRange!.end)
            cursorRect.size.height += 8 // 추가 여백
            textView.scrollRectToVisible(cursorRect, animated: true)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 텍스트 변화 처리
    }
}

// MARK: - UIDragInteractionDelegate, UIDropInteractionDelegate 구현
extension WritingPageVC: UIDragInteractionDelegate, UIDropInteractionDelegate {
    // UIDragInteractionDelegate 구현
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        // Drag 시작 시 처리할 내용
        return []
    }

    // UIDropInteractionDelegate 구현
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        // Drop 수행 시 처리할 내용
    }
    // 필요한 다른 Delegate 메소드들을 여기에 추가
}

// MARK: - Image Picker
extension WritingPageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc private func imagePickerButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        // 이미지를 NSTextAttachment 객체로 변환
        let textAttachment = NSTextAttachment()
        textAttachment.image = selectedImage
        
        // NSAttributedString 생성
        let attributedStringWithImage = NSAttributedString(attachment: textAttachment)
        
        // 플레이스 홀더 숨기기
        if writingPageView.contentTextView.textColor == UIColor.lightGray {
            writingPageView.contentTextView.text = nil
            writingPageView.contentTextView.textColor = UIColor.black
        }

        // contentTextView의 현재 텍스트에 이미지 추가
        if let oldText = writingPageView.contentTextView.attributedText {
            let newText = NSMutableAttributedString(attributedString: oldText)
            newText.append(attributedStringWithImage)
            writingPageView.contentTextView.attributedText = newText
        } else {
            writingPageView.contentTextView.attributedText = attributedStringWithImage
        }
        
        // 텍스트 뷰의 편집 상태 설정
        writingPageView.contentTextView.becomeFirstResponder()
        
        picker.dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Actions
extension WritingPageVC {
    // "Done" 버튼 액션 구현
    @objc private func doneButtonTapped() {
        // 키보드 숨기기 또는 필요한 작업 수행
        self.view.endEditing(true)
    }
}
