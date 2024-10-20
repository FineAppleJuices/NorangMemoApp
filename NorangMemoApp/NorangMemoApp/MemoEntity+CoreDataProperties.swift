//
//  MemoEntity+CoreDataProperties.swift
//  NorangMemoApp
//
//  Created by Kyuhee hong on 10/20/24.
//
//

import Foundation
import CoreData


extension MemoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoEntity> {
        return NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var content: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var modifiedAt: Date?
    @NSManaged public var title: String?

}

extension MemoEntity : Identifiable {

}
