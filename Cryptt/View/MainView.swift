//
//  MainView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

struct MainView: View {
    
    //MARK: View
    var body: some View {
        TabView {
            StaticView()
                .tabItem {
                    Label("Statistics", systemImage: "arrow.down.left.arrow.up.right.circle.fill")
                }
            RecordView()
                .tabItem {
                    Label("Records", systemImage: "book.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}


#Preview {
    MainView()
}
