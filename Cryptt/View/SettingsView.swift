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
                        }
                        label: {
                            Text("Who I am ?")
                                .foregroundStyle(.white)
                                .padding(.top, geometry.size.height/20)
                                .padding(.bottom, geometry.size.height/20)
                                .padding(.trailing, geometry.size.height/20)
                        }.background(Color.blue)
                            
                            .frame(width:geometry.size.width / 2, height: geometry.size.height / 4)

                        
                        
                    }
                }
            }.navigationTitle(Text("About us"))
        }
    }
}

#Preview {
    SettingsView()
}
