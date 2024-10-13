//
//  MemoEntity+CoreDataProperties.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 10/13/24.
//
//

import Foundation
import CoreData


extension MemoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoEntity> {
        return NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var modifiedAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var content: String?
    @NSManaged public var category: String?

}

extension MemoEntity : Identifiable {

}
