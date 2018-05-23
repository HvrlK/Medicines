//
//  Medicine+CoreDataProperties.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/23/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//
//

import Foundation
import CoreData


extension Medicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medicine> {
        return NSFetchRequest<Medicine>(entityName: "Medicine")
    }

    @NSManaged public var name: String
    @NSManaged public var price: Double
    @NSManaged public var producer: String
    @NSManaged public var descriptionOfMedicine: String
    @NSManaged public var category: String

}
