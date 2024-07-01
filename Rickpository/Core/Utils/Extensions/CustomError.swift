//
//  CustomError.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation

enum URLError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .addressUnreachable(let url): return "\(url.absoluteString) is not available."
        case .invalidResponse: return "The server is kinda responding with trash."
        }
    }
}

enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instantiate"
        case .requestFailed: return "Request failed."
        }
    }
}
