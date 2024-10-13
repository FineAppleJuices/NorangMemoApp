//
//  Model.swift
//  NorangMemoApp
//
//  Created by Kyuhee hong on 9/17/24.
//

import Foundation
import CoreData

struct MemoModel: Identifiable, Equatable {
    let id: String
    var title: String
    var content: String
    let createdAt: Date = Date()
    var modifiedAt: Date?
    var category: Category
}

extension MemoModel {
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> MemoEntity {
        
        let memo: MemoEntity = .init(context: context)
        memo.id = self.id
        memo.title = self.title
        memo.content = self.content
        memo.createdAt = self.createdAt
        if let modifiedAt = self.modifiedAt {
            memo.modifiedAt = modifiedAt
        }
        memo.category = self.category.rawValue
        
        return memo
    }
    
    static func mapFromEntity(_ entity: MemoEntity) -> Self {
        let id = entity.id ?? UUID().uuidString
        let title = entity.title ?? ""
        let content = entity.content ?? ""
        let modifiedAt = entity.modifiedAt
        let category = Category(rawValue: entity.category ?? "") ?? Category.todos
        
        return MemoModel(id: id, title: title, content: content, modifiedAt: modifiedAt, category: category)
    }
    
}

enum Category: String, CaseIterable {
    case work = "업무"
    case personal = "개인"
    case ideas = "아이디어"
    case todos = "할 일"
}
