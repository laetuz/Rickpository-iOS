//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Foundation

public struct CharactersResponse: Decodable {
    let results: [CharacterResponse]
}

public struct CharacterResponse: Decodable {
    
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let image: String?
    let origin: OriginResponse?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case image
        case origin
    }
    
    public struct OriginResponse: Decodable {
        let name: String?
        let url: String?
        
        enum CodingKeys: CodingKey {
            case name
            case url
        }
    }



}

