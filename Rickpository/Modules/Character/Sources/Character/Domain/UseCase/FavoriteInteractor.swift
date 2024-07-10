//
//  FavoriteInteractor.swift
//  Rickpository
//
//  Created by Ryo Martin on 03/07/24.
//

import Foundation
import Combine
import Core

public protocol FavoriteUseCase {
    func getCharacters() -> AnyPublisher<[CharacterDomainModel], Error>
}

public class FavoriteInteractor: FavoriteUseCase {
    private let repo: RickRepositoryProtocol
    
    public init(repo: RickRepositoryProtocol) {
        self.repo = repo
    }
    
    public func getCharacters() -> AnyPublisher<[CharacterDomainModel], any Error> {
        return repo.getFavorite()
    }
}
