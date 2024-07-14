//
//  HomeInteractor.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine
import Core

public protocol HomeUseCase {
    func getCharacters() -> AnyPublisher<[CharacterDomainModel], Error>
}

public class HomeInteractor: HomeUseCase {
    private let repo: RickRepositoryProtocol
    
    public init(repo: RickRepositoryProtocol) {
        self.repo = repo
    }
    
    public func getCharacters() -> AnyPublisher<[CharacterDomainModel], any Error> {
        return repo.getCharacters()
    }
}
