//
//  Singer+CoreDataProperties.swift
//  CoreDataSwiftUISandbox
//
//  Created by Atin Agnihotri on 04/07/21.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String {
        firstName ?? "Unknown first name"
    }
    
    var wrappedLastName: String {
        lastName ?? "Unknown last name"
    }

}

extension Singer : Identifiable {

}
