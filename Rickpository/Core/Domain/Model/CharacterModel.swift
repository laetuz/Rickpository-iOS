//
//  CharacterModel.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation

struct CharacterModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: Origin?
    let favorite: Bool
    
    struct Origin: Equatable {
        let name: String
        let url: String
    }
    
    init(id: Int, name: String, status: String, species: String, gender: String, image: String, origin: OriginEntity?, favorite: Bool) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
        self.origin = origin.map { Origin(name: $0.name, url: $0.url)}
        self.favorite = favorite
    }
}
