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
                    .opacity(isActive ? 1 : 0)
                    .animation(.default, value: isActive)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    
                
                
                LifeActiveView()
                    .opacity(isActive ? 0 : 1)
                    .animation(.default, value: isActive)
            }
        }.onChange(of: scenePhase) { oldValue, newValue in
            switch newValue{
                
            }
        }
    }
}
