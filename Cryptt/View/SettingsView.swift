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
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .padding(.horizontal, geometry.size.height/8)
                                .padding(.bottom, geometry.size.height/70)
                                .padding(.top, geometry.size.height/70)

                                .foregroundStyle(Color.gray.opacity(0.3))
                            
                            RoundedRectangle(cornerRadius: 10)
                                .padding(.horizontal, geometry.size.height / 20)
                                .foregroundStyle(Color.gray.opacity(0.3))
                            Image("metelykx", bundle: nil)
                                .resizable()
                                .scaledToFit()
                                .padding(.top, geometry.size.height/35)
                                .padding(.bottom, geometry.size.height/35)
                        }
                           
                        
                        
                        
                        
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
                            .alert(isPresented: $isTrue) {
                                Alert(title: Text("About Me"),
                                      message: Text("My name is metelykx! I am 19 years old. I wanna to work with Pavel Durov")
                                )
                            }
                            
                        
                        
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                    
                }
            }.navigationTitle(Text("About us"))
        }
    }
}

#Preview {
    SettingsView()
}
