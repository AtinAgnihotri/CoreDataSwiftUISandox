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
    @State var lastNameFilter = "A"
//    @FetchRequest(entity: Singer.entity(),
//        sortDescriptors: [],
////        predicate: NSPredicate(format: "universe == 'Expanse'"),
////        predicate: NSPredicate(format: "universe==%@", "Mass Effect", "Expanse"),
////        predicate: NSPredicate(format: "name BEGINSWITH %@", "S"),
////        predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "S"),
////        predicate: NSPredicate(format: "NOT name BEGINSWITH %@", "S"),
//        //CONTAINS[c]
//        animation: .default)
//    private var singers: FetchedResults<Singer>
    let students = [Student(name: "Harry Potter"), Student(name: "Hermoine Granger"), Student(name: "Ron Weasely")]
    @FetchRequest(entity: Country.entity(),
                  sortDescriptors: [],
                  animation: nil) var countries: FetchedResults<Country>

    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button("Add") {
                let candy1 = Candy(context: self.viewContext)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.viewContext)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: self.viewContext)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.viewContext)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: self.viewContext)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.viewContext)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: self.viewContext)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.viewContext)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? self.viewContext.save()
            }
            FilteredList(key: "fullName", value: "u", sortDescriptors: [], predicate: .beginsWithCaseless) { (country: Country) in
                Text("\(country.wrappedFullName)")
            }.foregroundColor(.primary)
            
            /*
             key filterKey: String,
                  value filterValue: String,
                  sortDescriptors: [NSSortDescriptor],
                  predicate: String,
                  @ViewBuilder content: @escaping (T) -> Content
             */
//            List (singers, id:\.self) { singer in
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }
            
//            FilteredList(key: "lastName", value: lastNameFilter) { (singer: Singer) in
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }
//            Button("Add Examples") {
//                let singer1 = Singer(context: self.viewContext)
//                singer1.firstName = "Tove"
//                singer1.lastName = "Lo"
//
//                let singer2 = Singer(context: self.viewContext)
//                singer2.firstName = "Marshall"
//                singer2.lastName = "Mathers"
//
//                let singer3 = Singer(context: self.viewContext)
//                singer3.firstName = "Austin"
//                singer3.lastName = "Post"
//
//                let singer4 = Singer(context: self.viewContext)
//                singer4.firstName = "Kendrick"
//                singer4.lastName = "Lamar"
//
//                let singer5 = Singer(context: self.viewContext)
//                singer5.firstName = "Amit"
//                singer5.lastName = "Trivedi"
//
//                let singer6 = Singer(context: self.viewContext)
//                singer6.firstName = "Tina"
//                singer6.lastName = "Turner"
//
//                try? self.viewContext.save()
//            }
//            Button("Show T") {
//                lastNameFilter = "T"
//            }
//            Button("Show L") {
//                lastNameFilter = "L"
//            }
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
