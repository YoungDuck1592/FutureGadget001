//
//  UITextView.swift
//  Memo
//
//  Created by 서영덕 on 11/21/23.
//

import Foundation
import UIKit

extension UITextView {
    func addBorder(color: UIColor = .gray, width: CGFloat = 0.5, cornerRadius: CGFloat = 5) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
