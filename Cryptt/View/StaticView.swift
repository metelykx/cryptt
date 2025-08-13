//
//  StaticView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

struct StaticView: View {
    
    
    @StateObject var art = ViewModel()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Statistics")
            }
        }
    }
}


#Preview {
    StaticView()
}
