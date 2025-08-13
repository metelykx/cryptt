//
//  ViewModel.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 13.08.2025.
//

import Foundation

class ViewModel: ObservableObject {
    
    //this is array for save info from API
    @Published var welcomes: [Datum] = []
    
    //func for show User info
    func fetchInfo() {
        
        //Task for async 
        Task {
            do {
                let welcome = try await NetworkManager().getInfo()
                welcomes = welcome.data
            } catch {
                if let error = error as? NetworkErrors {
                    print(error)
                }
            }
        }
    }
}
