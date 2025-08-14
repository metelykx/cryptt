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
                                .padding(.leading, geometry.size.height/20)
                                .font(.title2)
                                .bold()
                            
                        }.background(Color.blue)
                            .cornerRadius(20)
                            .padding(.bottom, geometry.size.height / 2)
                            
                        
                        
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                    
                }
            }.navigationTitle(Text("About us"))
        }
    }
}

#Preview {
    SettingsView()
}
