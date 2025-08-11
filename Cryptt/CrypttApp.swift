//
//  CrypttApp.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

@main
struct CrypttApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                
                
                RecordView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
