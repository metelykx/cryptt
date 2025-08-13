//
//  Model.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 13.08.2025.
//

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    let data: [Datum]
    let timestamp: Int
}

// MARK: - Datum
struct Datum: Codable {
    let rank, symbol, name: String
    let supply: String
    let maxSupply: String?
    let marketCapUsd, volumeUsd24Hr, priceUsd, changePercent24Hr: String
}

