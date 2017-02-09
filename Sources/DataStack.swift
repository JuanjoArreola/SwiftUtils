//
//  DataStack.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation
import CoreData

public enum DataStackError: Error {
    case pathError
    case invalidManagedObjectModel
}

public class DataStack {
    
    private(set) public var managedObjectModel: NSManagedObjectModel!
    private(set) public var managedObjectContext: NSManagedObjectContext!
    private(set) public var dataStoreURL: URL!
    
    convenience public init(modelName: String, dataStoreName: String, options: [String: Any]? = nil, concurrencyType: NSManagedObjectContextConcurrencyType = .mainQueueConcurrencyType) throws {
        let documents = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let dataStoreURL = documents.appendingPathComponent("\(dataStoreName).sqlite")
        guard let momURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            throw DataStackError.pathError
        }
        try self.init(managedObjectModelURL: momURL, dataStoreURL: dataStoreURL, options: options, concurrencyType: concurrencyType)
    }
    
    required public init(managedObjectModelURL momURL: URL, dataStoreURL: URL, options: [String: Any]?, concurrencyType: NSManagedObjectContextConcurrencyType) throws {
        self.dataStoreURL = dataStoreURL
        managedObjectModel = NSManagedObjectModel(contentsOf: momURL)
        if managedObjectModel == nil {
            throw DataStackError.invalidManagedObjectModel
        }
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dataStoreURL, options: options)
        managedObjectContext = NSManagedObjectContext(concurrencyType: concurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
    }
    
}
