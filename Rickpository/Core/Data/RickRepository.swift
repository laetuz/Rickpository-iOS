//
//  RickRepository.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine

protocol RickRepositoryProtocol {
    func getCharacters() -> AnyPublisher<[CharacterModel], Error>
    func favCharacter(by id: Int) -> AnyPublisher<CharacterModel, Error>
    func getFavorite() -> AnyPublisher<[CharacterModel], Error>
}

final class RickRepository: NSObject {
    typealias RickInstance = (LocalDataSource, RemoteDataSource) -> RickRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(local: LocalDataSource, remote: RemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: RickInstance = { localRepo, remoteRepo in
        return RickRepository(local: localRepo, remote: remoteRepo)
    }
}

extension RickRepository: RickRepositoryProtocol {
    func getCharacters() -> AnyPublisher<[CharacterModel], any Error> {
        return self.local.getCharacters()
            .flatMap { result -> AnyPublisher<[CharacterModel], Error> in
                if result.isEmpty {
                    return self.remote.getCharacters()
                        .map { CharacterMapper.mapCharacterResponsesToEntities(input: $0)}
                        .catch { _ in self.local.getCharacters()}
                        .flatMap { self.local.addCharacters(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getCharacters()
                                .map { CharacterMapper.mapCharacterEntitiesToDomains(input: $0)}
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getCharacters()
                        .map { CharacterMapper.mapCharacterEntitiesToDomains(input: $0)}
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
        
    }
    
    func favCharacter(by id: Int) -> AnyPublisher<CharacterModel, any Error> {
        return self.local.addFavorite(by: id)
            .map { CharacterMapper.mapCharacterEntitiesToDomainsFav(input: $0)}
            .eraseToAnyPublisher()
    }
    
    func getFavorite() -> AnyPublisher<[CharacterModel], any Error> {
        return self.local.getFavoriteCharacters()
            .map { CharacterMapper.mapCharacterEntitiesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }
}
