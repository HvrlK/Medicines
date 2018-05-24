//
//  Account+CoreDataProperties.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/24/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var email: String
    @NSManaged public var password: String
    @NSManaged public var name: String
    @NSManaged public var phoneNumber: String

}
