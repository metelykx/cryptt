//
//  LifeActiveView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI


struct LifeActiveView: View {
    
    //MARK: colors
    @Environment(\.colorScheme) private var colorScheme
    
    private var colors: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    //MARK: View
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                
                Circle1View(size: geometry.size)
                Circle2View(size: geometry.size)
                
                VStack {
                    HStack {
                        Text("CryptoGraf")
                            .font(.title)
                            .bold()
                            .fontWidth(.compressed)
                            .foregroundStyle(colors)
                        
                        Image(systemName: "bitcoinsign.bank.building.fill")
                            .resizable()
                            .frame(width: geometry.size.width / 10, height: geometry.size.height / 20)
                            .foregroundStyle(.yellow)
                    }.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
#Preview {
    LifeActiveView()
}
