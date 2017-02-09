//
//  ManagedObjectRepository.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation
import CoreData

open class ManagedObjectRepository<ManagedObject: NSManagedObject>: NSObject {
    
    private(set) public var moc: NSManagedObjectContext!
    private(set) public var entityDescription: NSEntityDescription!
    private(set) public var entityName: String!
    
    required public init?(managedObjectContext: NSManagedObjectContext) {
        super.init()
        if let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: ManagedObject.self), in: managedObjectContext) {
            self.entityDescription = entityDescription
            self.moc = managedObjectContext
            if self.entityDescription.name == nil {
                return nil
            }
            self.entityName = self.entityDescription.name!
        } else {
            return nil
        }
    }
    
    //    MARK: - Create
    
    public func create() -> ManagedObject? {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: moc) as? ManagedObject
    }
    
    public func save(_ object: ManagedObject) throws -> ManagedObject {
        if moc.hasChanges {
            try moc.save()
        }
        return object
    }
    
    public func getOrCreate(with predicate: NSPredicate) throws -> ManagedObject {
        let fetchRequest: NSFetchRequest<ManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        if let object = try moc.fetch(fetchRequest).first {
            return object
        }
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: moc) as! ManagedObject
    }
    
    //    MARK: - Fetch
    
    public func all() -> [ManagedObject] {
        let request: NSFetchRequest<ManagedObject> = NSFetchRequest(entityName: entityName)
        if let result = try? moc.fetch(request) {
            return result
        }
        return []
    }
    
    public func get(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) throws -> [ManagedObject] {
        let fetchRequest: NSFetchRequest<ManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        return try moc.fetch(fetchRequest)
    }
    
    // MARK: - Delete
    
    public func delete(_ object: ManagedObject, commit: Bool = true) throws {
        moc.delete(object)
        if commit {
            try moc.save()
        }
    }
    
    public func delete(_ objects: [ManagedObject], commit: Bool = true) throws {
        for object in objects {
            moc.delete(object)
        }
        if commit {
            try moc.save()
        }
    }
    
}

open class ManagedIdentifiableObjectRepository<ManagedObject: NSManagedObject, IdType: Any>: ManagedObjectRepository<ManagedObject> {

    public func get(id: IdType) throws -> ManagedObject? {
        let fetchRequest: NSFetchRequest<ManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == \"\(id)\"")
        return try moc.fetch(fetchRequest).first
    }

    public func getOrCreate(id: IdType) throws -> ManagedObject {
        let fetchRequest: NSFetchRequest<ManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == \"\(id)\"")
        if let object = try moc.fetch(fetchRequest).first {
            return object
        }
        let object = NSEntityDescription.insertNewObject(forEntityName: entityDescription.name!, into: moc) as! ManagedObject
        (object as NSManagedObject).setValue(id, forKey: "id")
        return object
    }
}
