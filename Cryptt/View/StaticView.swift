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
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                
                ForEach(art.welcomes, id: \.id) { article in
                    ShowInfoView(infos: article)
                }
            }
        }.onAppear {
            art.fetchInfo()
        }
    }
}


#Preview {
    StaticView()
}
