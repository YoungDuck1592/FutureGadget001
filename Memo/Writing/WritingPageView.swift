//
//  WritingPageView.swift
//  Memo
//
//  Created by 서영덕 on 11/14/23.
//

import UIKit
import SnapKit
import Then

class WritingPageView: UIScrollView {
    
    // 각 텍스트 뷰에 대한 높이 제약조건을 저장할 프로퍼티
    private var titleTextViewHeightConstraint: Constraint?
    private var hashtagTextViewHeightConstraint: Constraint?
    private var contentTextViewHeightConstraint: Constraint?
    
    let titleTextView = UITextView().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.text = "제목을 입력하세요"
        $0.textColor = UIColor.lightGray
    }

    let hashtagTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.text = "해시태그를 입력하세요"
        $0.textColor = UIColor.lightGray
    }

    let contentTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isEditable = true
        $0.isUserInteractionEnabled = true
        $0.text = "내용을 입력하세요"
        $0.textColor = UIColor.lightGray
    }
    
    let imagePickerButton: UIButton = {
        let button = UIButton(type: .custom)
        if let image = UIImage(named: "Album") {
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
        }
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        showsVerticalScrollIndicator = true
        alwaysBounceVertical = true
        setupTextViews()
        setupToolbar(for: titleTextView)
        setupToolbar(for: hashtagTextView)
        setupToolbar(for: contentTextView)
        titleTextView.delegate = self
        hashtagTextView.delegate = self
        contentTextView.delegate = self
        
    }
    
    private func setupTextViews() {
        addSubview(titleTextView)
        addSubview(hashtagTextView)
        addSubview(contentTextView)
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40).priority(.low)
        }
        
        hashtagTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40).priority(.low)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(hashtagTextView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(100).priority(.low)
        }
    }

    
    private func setupToolbar(for textView: UITextView) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        imagePickerButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        stackView.addArrangedSubview(imagePickerButton)
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(scrollView)
        }
        
        let scrollViewContainer = UIView()
        scrollViewContainer.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let scrollContainer = UIBarButtonItem(customView: scrollViewContainer)

        // 'Done' 버튼을 UIBarButtonItem으로 변환
        let doneButtonItem = UIBarButtonItem(customView: doneButton)

        toolbar.setItems([scrollContainer, doneButtonItem], animated: false)
        textView.inputAccessoryView = toolbar
    }
}
    
extension WritingPageView: UITextViewDelegate {
    
    // UITextViewDelegate 메서드
    func textViewDidChange(_ textView: UITextView) {
        // 텍스트 뷰의 새로운 높이 계산 및 업데이트
        let newSize = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.infinity))
        let newHeight = newSize.height
        if textView == titleTextView {
            titleTextViewHeightConstraint?.update(offset: newHeight)
        } else if textView == hashtagTextView {
            hashtagTextViewHeightConstraint?.update(offset: newHeight)
        } else if textView == contentTextView {
            contentTextViewHeightConstraint?.update(offset: newHeight)
        }
        
        // 레이아웃 업데이트
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }

        // 스크롤 뷰의 contentSize 업데이트
        updateScrollViewContentSize()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            switch textView {
            case titleTextView:
                textView.text = "제목을 입력하세요"
            case hashtagTextView:
                textView.text = "해시태그를 입력하세요"
            case contentTextView:
                textView.text = "내용을 입력하세요"
            default:
                break
            }
            textView.textColor = UIColor.lightGray
        }
    }
    
    // 스크롤 뷰의 contentSize를 업데이트하는 메서드
    private func updateScrollViewContentSize() {
        let extraSpace: CGFloat = 100
        let totalHeight = titleTextView.frame.maxY + hashtagTextView.frame.height + contentTextView.frame.height + extraSpace
        contentSize = CGSize(width: frame.width, height: totalHeight)
    }
}
