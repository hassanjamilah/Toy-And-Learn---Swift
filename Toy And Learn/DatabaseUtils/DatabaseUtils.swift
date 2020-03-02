//
//  File.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation
import CoreData

class DatabaseUtils {
    let databaseContainer:NSPersistentContainer
    
    
    init(modelName:String) {
        databaseContainer = NSPersistentContainer(name: modelName)
    }
    
    var context:NSManagedObjectContext {
        return databaseContainer.viewContext
    }
    
    func load (){
        databaseContainer.loadPersistentStores { (persistantDesc, error) in
            guard error == nil else {
                fatalError("Error in loading persistant data")
            }
        }
    }
    
    static let shared = DatabaseUtils.init(modelName: "Toy_And_Learn")
    
    
}
