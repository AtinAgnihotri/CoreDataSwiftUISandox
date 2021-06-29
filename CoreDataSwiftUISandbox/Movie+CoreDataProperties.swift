//
//  Movie+CoreDataProperties.swift
//  CoreDataSwiftUISandbox
//
//  Created by Atin Agnihotri on 29/06/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var director: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Int16
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }

}

extension Movie : Identifiable {

}
