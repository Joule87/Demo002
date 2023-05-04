//
//  RequestError.swift
//  Demo002
//
//  Created by Julio Collado Perez on 4/30/23.
//

import Foundation

enum RequestError: Error, LocalizedError {
    case badURL
    case badResponse(url: URL, statusCode: Int)
    case error(description: String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badResponse(url: let url, statusCode: let code):
            return "[❌] Bad response from \(url.absoluteString), Status code: \(code)"
        case .unknown:
            return "[❌] Unknown error occurred"
        case .badURL:
            return "[❌] Bad URL"
        case .error(description: let description):
            return "[❌] Error: \(description)"
        }
    }
}
