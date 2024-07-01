//
//  APICall.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation

struct API {
    static let baseUrl = "https://rickandmortyapi.com/api/"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case characters
        
        public var url: String {
            switch self {
            case .characters: return "\(API.baseUrl)character"
            }
        }
    }
}
