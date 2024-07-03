//
//  FavoriteInteractor.swift
//  Rickpository
//
//  Created by Ryo Martin on 03/07/24.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getCharacters() -> AnyPublisher<[CharacterModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repo: RickRepositoryProtocol
    
    required init(repo: RickRepositoryProtocol) {
        self.repo = repo
    }
    
    func getCharacters() -> AnyPublisher<[CharacterModel], any Error> {
        return repo.getFavorite()
    }
}
