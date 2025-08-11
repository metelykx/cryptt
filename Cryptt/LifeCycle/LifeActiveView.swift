//
//  LifeActiveView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI


struct LifeActiveView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var colors: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
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
                    }
                }
            }
        }
    }
}
#Preview {
    LifeActiveView()
}
