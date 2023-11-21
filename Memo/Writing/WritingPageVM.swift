//
//  WritingPageVM.swift
//  Memo
//
//  Created by 서영덕 on 11/14/23.
//

import Foundation

class WritingPageVM {
    // ViewModel 로직
    var text: String = ""

    func saveText(_ newText: String) {
        text = newText
        // 데이터 처리 로직
    }
}
