//
//  CharacterMapper.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation

final class CharacterMapper {
    static func mapCharacterResponsesToEntities(
        input characterResponses: [CharacterResponse]
    ) -> [CharacterEntity] {
        return characterResponses.map { result in
            let newCharacter = CharacterEntity()
            newCharacter.id = result.id ?? 0
            newCharacter.name = result.name ?? ""
            newCharacter.status = result.status ?? ""
            newCharacter.species = result.species ?? ""
            newCharacter.image = result.image ?? ""
            
            if let originResponse = result.origin {
                let originEntity = OriginEntity()
                originEntity.name = result.origin?.name ?? ""
                originEntity.url = result.origin?.url ?? ""
                newCharacter.origin = originEntity
            }
            
            return newCharacter
        }
    }
    
    
    static func mapCharacterEntitiesToDomains(
        input characterEntities: [CharacterEntity]
    ) -> [CharacterModel] {
        return characterEntities.map { result in
            return CharacterModel(
                id: result.id,
                name: result.name,
                status: result.status,
                species: result.species,
                gender: result.gender,
                image: result.image,
                origin: result.origin,
                favorite: result.favorite
            )
        }
    }
    
    static func mapCharacterEntitiesToDomainsFav(
        input characterEntity: CharacterEntity
    ) -> CharacterModel {
        return CharacterModel(id: characterEntity.id, name: characterEntity.name, status: characterEntity.status, species: characterEntity.species, gender: characterEntity.gender, image: characterEntity.image, origin: characterEntity.origin, favorite: characterEntity.favorite)
//        return characterEntities.map { result in
//            return CharacterModel(
//                id: result.id,
//                name: result.name,
//                status: result.status,
//                species: result.species,
//                gender: result.gender,
//                image: result.image,
//                origin: result.origin,
//                favorite: result.favorite
//            )
//        }
    }
}
