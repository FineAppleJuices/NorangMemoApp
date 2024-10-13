//
//  CoreDataManager.swift
//  NorangMemoApp
//
//  Created by Kyuhee Hong on 10/13/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    // Persistent Container
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MemoModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    // Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Save Context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Create Memo
    func createMemo(_ memoModel: MemoModel) {
        let _ = memoModel.mapToEntityInContext(context)
        saveContext()
    }
    
    // Read All Memos
    func fetchAllMemos() -> [MemoModel] {
        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
        
        do {
            let memoEntities = try context.fetch(fetchRequest)
            return memoEntities.map { MemoModel.mapFromEntity($0) }
        } catch {
            print("Error fetching memos: \(error)")
            return []
        }
    }
    
    // Update Memo
    func updateMemo(_ memoModel: MemoModel) {
        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", memoModel.id)
        
        do {
            if let entity = try context.fetch(fetchRequest).first {
                entity.title = memoModel.title
                entity.content = memoModel.content
                entity.modifiedAt = memoModel.modifiedAt
                entity.category = memoModel.category.rawValue
                saveContext()
            }
        } catch {
            print("Error updating memo: \(error)")
        }
    }
    
    // Delete Memo
    func deleteMemo(_ memoModel: MemoModel) {
        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", memoModel.id)
        
        do {
            if let entity = try context.fetch(fetchRequest).first {
                context.delete(entity)
                saveContext()
            }
        } catch {
            print("Error deleting memo: \(error)")
        }
    }
}
