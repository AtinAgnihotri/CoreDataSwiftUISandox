//
//  CoreDataSwiftUISandboxApp.swift
//  CoreDataSwiftUISandbox
//
//  Created by Atin Agnihotri on 26/06/21.
//

import SwiftUI

@main
struct CoreDataSwiftUISandboxApp: App {
    let persistenceController = PersistenceController.shared
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
