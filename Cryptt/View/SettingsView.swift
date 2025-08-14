//
//  SettingsView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @State var isTrue = false
    
    var body: some View {
        NavigationView {
            ZStack {
           
                GeometryReader { geometry in
                    VStack {
                        
                        Button {
                            isTrue = true
                        } label: {
                            Text("Who I am ?")
                        }

                        
                        
                    }
                }
            }.navigationTitle(Text("About us"))
        }
    }
}

#Preview {
    SettingsView()
}
