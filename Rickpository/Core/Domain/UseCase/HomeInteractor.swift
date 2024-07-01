//
//  HomeInteractor.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getCharacters() -> AnyPublisher<[CharacterModel], Error>
}

class HomeInteractor: HomeUseCase {
    private let repo: RickRepositoryProtocol
    
    required init(repo: RickRepositoryProtocol) {
        self.repo = repo
    }
    
    func getCharacters() -> AnyPublisher<[CharacterModel], any Error> {
        return repo.getCharacters()
    }
}
