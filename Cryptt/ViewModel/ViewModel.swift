//
//  ViewModel.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 13.08.2025.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var welcomes: [Datum] = []
    
    func fetchInfo() {
        Task {
            do {
                let welcome = try await NetworkManager().getInfo()
                welcomes = welcome.data
            } catch {
                if let 
            }
        }
    }
}
