//
//  ButtonView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

struct ButtonView: View {
    
    let size: CGSize
    
    //MARK: View
    var body: some View {
        Button {
            print("Sign Up tapped")
        } label: {
            Text("Sign Up")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, size.height * 0.03)
         
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal, size.width * 0.2)
        .padding(.top, size.height * 0.03)
    }
}
