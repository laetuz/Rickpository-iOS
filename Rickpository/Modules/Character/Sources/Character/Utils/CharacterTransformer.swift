//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Foundation
import Core

public struct CharacterTransformer: Mapper {
    public typealias Request = Any
    public typealias Response = [CharacterResponse]
    public typealias Entity = [CharacterEntityModule]
    public typealias Domain = [CharacterDomainModel]
    
    public init() {}
    
    public func transformEntityToDomain(entity: [CharacterEntityModule]) -> [CharacterDomainModel] {
        return entity.map { result in
            return CharacterDomainModel(
                id: result.id,
                name: result.name,
                status: result.status,
                species: result.species,
                gender: result.gender, 
                image: result.image,
                origin: result.origin!, 
                favorite: result.favorite)
        }
    }
    
    public func transformResponseToEntity(response: [CharacterResponse]) -> [CharacterEntityModule] {
        return response.map { result in
            let newChar = CharacterEntityModule()
            newChar.id = result.id ?? 0
            newChar.name = result.name ?? ""
            newChar.status = result.status ?? ""
            newChar.species = result.species ?? ""
            newChar.gender = result.gender ?? ""
            newChar.image = result.image ?? ""
            
            if let originResponse = result.origin {
                let originEntity = OriginEntityModule()
                originEntity.name = result.origin?.name ?? ""
                originEntity.url = result.origin?.url ?? ""
                newChar.origin = originEntity
            }
            
            return newChar
        }
    }
}
