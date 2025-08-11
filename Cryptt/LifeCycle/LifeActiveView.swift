//
//  LifeActiveView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI


struct LifeActiveView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var colors: {
        
    }
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                
                HStack {
                    Text("CryptoGraf")
                        .font(.title)
                        .bold()
                        .fontWidth(.compressed)
                        .foregroundStyle(colors)
                }
            }
        }
    }
}
#Preview {
    LifeActiveView()
}
