//
//  CharacterMapper.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation

final class CharacterMapper {
    static func mapCharacterResponsesToEntities(
        input characterRespones: [CharacterResponse]
    ) -> [CharacterEntity] {
        return characterRespones.map { result in
            let newCharacter = CharacterEntity()
            newCharacter.id = result.id ?? 0
            newCharacter.name = result.name ?? ""
            newCharacter.status = result.status ?? ""
            newCharacter.species = result.species ?? ""
            newCharacter.image = result.image ?? ""
            return newCharacter
        }
    }
    
    static func mapCharacterEntitiesToDomains(
        input characterEntities: [CharacterEntity]
    ) -> [CharacterModel] {
        return characterEntities.map { result in
            return CharacterModel(id: result.id, name: result.name, status: result.status, species: result.species, gender: result.gender, image: result.image)
        }
    }
    
    static func mapCharacterResponsesToDomains(
        input characterResponses: [CharacterResponse]
    ) -> [CharacterModel] {
        return characterResponses.map { result in
            return CharacterModel(
                id: result.id ?? 0,
                name: result.name ?? "",
                status: result.status ?? "",
                species: result.species ?? "",
                gender: result.gender ?? "",
                image: result.image ?? ""
            )
        }
    }
}
