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
    
    //variable for work with API
    let url: String = "https://rest.coincap.io/v3/assets?apiKey=d2d7706e70cf8db5cd453f3b1989523b6ee2c881d1ba727dd6ae200822288df2"
    let decoder = JSONDecoder()
    
    
    
    //MARK: Function
    func getInfo() async throws -> Welcome{
        
        //in the here we check is URL or no
        guard let url = URL(string: url) else {
            throw NetworkErrors.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkErrors.invalidResponse
        }
        do {
            return try decoder.decode(Welcome.self, from: data)
        }
        catch {
            throw NetworkErrors.invalidData
        }
    }
    
}

