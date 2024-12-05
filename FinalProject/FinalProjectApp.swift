//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Joshua Mendiola on 12/3/24.
//

import SwiftUI

@main
struct FinalProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(isLoggedIn: false, isStudent: true)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
