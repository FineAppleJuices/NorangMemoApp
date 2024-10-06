//
//  Model.swift
//  NorangMemoApp
//
//  Created by Kyuhee hong on 9/17/24.
//

import Foundation

struct Memo: Equatable {
    let id: String = UUID().uuidString
    var title: String
    var content: String
    var category: Category
    
    init(title: String, content: String, category: Category) {
        self.title = title
        self.content = content
        self.category = category
    }
}

enum Category: String, CaseIterable {
    case work = "업무"
    case personal = "개인"
    case ideas = "아이디어"
    case todos = "할 일"
}
