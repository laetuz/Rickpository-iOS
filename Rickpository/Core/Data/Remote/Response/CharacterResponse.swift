//
//  CharacterResponse.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation

struct CharactersResponse: Decodable {
    let results: [CharacterResponse]
}

struct CharacterResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
      case id = "id"
      case name = "name"
        case status = "status"
        case species = "species"
        case gender = "gender"
      case image = "image"
    }
    
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let image: String?
}
