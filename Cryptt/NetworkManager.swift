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
    let keys: String = "d2d7706e70cf8db5cd453f3b1989523b6ee2c881d1ba727dd6ae200822288df2"
    
    
    func getInfo() async throws {
        
    }
    
}
