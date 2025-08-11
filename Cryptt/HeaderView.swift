//
//  HeaderView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

struct HeaderView: View {
    let sizes: CGSize
    @Environment(\.colorScheme) private var colorScheme
    
   
    var body: some View {
        HStack {
            Text("Welcome to Crypt")
                .font(.title)
                .bold()
                .fontWidth(.compressed)
                .foregroundStyle(textColor)
            
            Image(systemName: "bitcoinsign.bank.building.fill")
                .resizable()
                .frame(width: sizes.width / 10, height: sizes.height / 20)
                .foregroundStyle(.yellow)
                
        }
    }
    private var textColor: Color {
            colorScheme == .dark ? .black : .white
        }
}

