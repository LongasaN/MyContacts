//
//  MyContacts+CoreDataProperties.swift
//  MyContacts
//
//  Created by Nina Longasa on 3/29/16.
//  Copyright © 2016 CHCAppDev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MyContacts {

        // These are required to store the data
    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var email: String

}
