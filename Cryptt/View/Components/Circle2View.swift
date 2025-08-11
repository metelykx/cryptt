//
//  Circle2View.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

struct Circle2View: View {
    let size: CGSize
    var body: some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: size.width / 2, height: size.height / 2)
            .rotationEffect(.init(degrees: 45))
            .offset(
                x: size.width / 1.6,
                y: size.height / 1.3
            )
    }
}
