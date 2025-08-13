//
//  NetworkErrors.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 13.08.2025.
//

import Foundation

enum NetworkErrors: String, Error {
    case invalidURL = "Invalid URL"
    case invalidResponse = "Invalid HTTP response"
    case invalidData = "Invalid data"
}

