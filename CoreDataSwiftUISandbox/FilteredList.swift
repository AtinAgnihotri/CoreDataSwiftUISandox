//
//  FilteredList.swift
//  CoreDataSwiftUISandbox
//
//  Created by Atin Agnihotri on 05/07/21.
//
import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content: (T) -> Content
    
    init(key filterKey: String, value filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest(
            entity: T.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K BEGINSWITH[c] %@", filterKey, filterValue),
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
