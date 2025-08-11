//
//  NetworkManager.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import Foundation

class NetworkManager: ObservableObject {
    
    
    //MARK: Singelton
    static let shared = NetworkManager()
    
    init() {
        
    }
    
    let url: String = "https://rest.coincap.io/v3/assets"
    let decoder = JSONDecoder()
    
}
