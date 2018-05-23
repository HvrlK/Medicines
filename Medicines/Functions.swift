//
//  Functions.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/16/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

func fetchRequestFromAccounts(_ context: NSManagedObjectContext) -> [Account] {
    let fetchRequest = NSFetchRequest<Account>()
    fetchRequest.entity = Account.entity()
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "email", ascending: true)]
    do {
        return try context.fetch(fetchRequest)
    } catch {
        fatalError("Fetch data error: \(error)")
    }
    
}

func fetchRequestFromMedicines(_ context: NSManagedObjectContext) -> [Medicine] {
    let fetchRequest = NSFetchRequest<Medicine>()
    fetchRequest.entity = Medicine.entity()
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    do {
        return try context.fetch(fetchRequest)
    } catch {
        fatalError("Fetch data error: \(error)")
    }
    
}

func context() -> NSManagedObjectContext {
    return appDelegate.managedObjectContext
}

func saveContext(_ context: NSManagedObjectContext) {
    do {
        try context.save()
    } catch {
        fatalError("Could save in data store: \(error)")
    }
}
