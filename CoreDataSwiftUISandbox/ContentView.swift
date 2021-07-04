//
//  ContentView.swift
//  CoreDataSwiftUISandbox
//
//  Created by Atin Agnihotri on 26/06/21.
//

import SwiftUI
import CoreData

struct Student: Hashable {
    var name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Ship.entity(),
        sortDescriptors: [],
//        predicate: NSPredicate(format: "universe == 'Expanse'"),
//        predicate: NSPredicate(format: "universe==%@", "Mass Effect", "Expanse"),
        predicate: NSPredicate(format: "universe in %@", ["Mass Effect", "Expanse"]),
//        predicate: NSPredicate(format: "name BEGINSWITH %@", "S"),
//        predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "S"),
//        predicate: NSPredicate(format: "NOT name BEGINSWITH %@", "S"),
        //CONTAINS[c]
        animation: .default)
    private var ships: FetchedResults<Ship>
    let students = [Student(name: "Harry Potter"), Student(name: "Hermoine Granger"), Student(name: "Ron Weasely")]

    var body: some View {
        VStack {
            List (ships, id:\.self) { ship in
                Text(ship.name ?? "Unknown Ship")
            }
            Button("Add Examples") {
                let ship1 = Ship(context: viewContext)
                ship1.name = "SSV Normandy SR-1"
                ship1.universe = "Mass Effect"
                
                let ship2 = Ship(context: viewContext)
                ship2.name = "Rocinante"
                ship2.universe = "Expanse"
                
                let ship3 = Ship(context: viewContext)
                ship3.name = "Millenium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: viewContext)
                ship4.name = "Starship Enterprise"
                ship4.universe = "Star Wars"
                
                try? self.viewContext.save()
            }
            Button("Save") {
                do {
                    if self.viewContext.hasChanges {
                        try self.viewContext.save()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        /*
         Although calculating the same hash for an object twice in a row should return the same value, calculating it between two runs of your app – i.e., calculating the hash, quitting the app, relaunching, then calculating the hash again – can return different values.
         */
        
//        List {
//            // Swift computes hash value of a struct and uses that for id through \.self
//            ForEach([2, 3, 5, 6, 8, 10], id:\.self) {
//                Text("\($0)")
//            }
//        }
//        List {
//            ForEach(items) { item in
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
    }
    
    /*
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
 */
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
