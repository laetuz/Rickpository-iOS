//
//  HomeInteractor.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getCharacters() -> AnyPublisher<[CharacterDomainModel], Error>
}

class HomeInteractor: HomeUseCase {
    private let repo: RickRepositoryProtocol
    
    required init(repo: RickRepositoryProtocol) {
        self.repo = repo
    }
    
    func getCharacters() -> AnyPublisher<[CharacterDomainModel], any Error> {
        return repo.getCharacters()
    }
}
