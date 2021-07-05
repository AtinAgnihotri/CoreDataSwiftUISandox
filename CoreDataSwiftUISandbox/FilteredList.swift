//
//  FilteredList.swift
//  CoreDataSwiftUISandbox
//
//  Created by Atin Agnihotri on 05/07/21.
//
import CoreData
import SwiftUI

enum Predicates: String {
    case beginsWith = "%K BEGINSWITH %@"
    case beginsWithCaseless = "%K BEGINSWITH[c] %@"
    case equals = "%K == %@"
    case notEquals = "NOT %K == %@"
    case contains = "%K CONTAINS %@"
    case containsCaseless = "%K CONTAINS[c] %@"
    case notContains = "NOT %K CONTAINS %@"
    case notContainsCaseless = "NOT %K CONTAINS[c] %@"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content: (T) -> Content
    
    init(key filterKey: String,
         value filterValue: String,
         sortDescriptors: [NSSortDescriptor],
         predicate: Predicates,
         @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(format: predicate.rawValue, filterKey, filterValue),
            animation: nil)
        self.content = content
    }
    
    var body: some View {
        List(items, id:\.self) { item in
            self.content(item)
        }
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList<NSManagedObject, <#Content: View#>>(filter: "A")
//    }
//}
