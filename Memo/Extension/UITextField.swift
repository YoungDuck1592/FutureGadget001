//
//  UITextField.swift
//  Memo
//
//  Created by 서영덕 on 11/14/23.
//

import Foundation
import UIKit


extension UITextField {
    func addBottomBorder(height: CGFloat = 1.0, color: UIColor = .black) {
        let bottomLine = UIView()
        bottomLine.backgroundColor = color
        self.addSubview(bottomLine)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.heightAnchor.constraint(equalToConstant: height).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let imageview = UIImageView()
        
        imageview.image = image
        imageview.tintColor = .black

        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        view.addSubview(imageview)
        imageview.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(8)
            make.height.width.equalTo(24)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(imageview.snp.right).offset(8)
            make.right.bottom.equalToSuperview().inset(8)
        }
        
        let dividerView = UIView()
        dividerView.backgroundColor = .black
        view.addSubview(dividerView)
        
        dividerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(0.75)
        }
        
        return view
    }
}
