//
//  RickRepository.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine
import Core

public protocol RickRepositoryProtocol {
    func getCharacters() -> AnyPublisher<[CharacterDomainModel], Error>
    func favCharacter(by id: Int) -> AnyPublisher<CharacterDomainModel, Error>
    func getFavorite() -> AnyPublisher<[CharacterDomainModel], Error>
}

public final class RickRepository: NSObject {
    public typealias RickInstance = (LocalDataSourceCore, RemoteDataSource) -> RickRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSourceCore
    
    private init(local: LocalDataSourceCore, remote: RemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    public static let sharedInstance: RickInstance = { localRepo, remoteRepo in
        return RickRepository(local: localRepo, remote: remoteRepo)
    }
}

extension RickRepository: RickRepositoryProtocol {
    public func getCharacters() -> AnyPublisher<[CharacterDomainModel], any Error> {
        return self.local.getCharacters()
            .flatMap { result -> AnyPublisher<[CharacterDomainModel], Error> in
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
    
    public func favCharacter(by id: Int) -> AnyPublisher<CharacterDomainModel, any Error> {
        return self.local.addFavorite(by: id)
            .map { CharacterMapper.mapCharacterEntitiesToDomainsFav(input: $0)}
            .eraseToAnyPublisher()
    }
    
    public func getFavorite() -> AnyPublisher<[CharacterDomainModel], any Error> {
        return self.local.getFavoriteCharacters()
            .map { CharacterMapper.mapCharacterEntitiesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }
}
