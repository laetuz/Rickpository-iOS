//
//  DetailInteractor.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine

protocol DetailUseCase {

    func getCharacter() -> CharacterDomainModel
    func favCharacter() -> AnyPublisher<CharacterDomainModel, Error>

}

class DetailInteractor: DetailUseCase {

    private let repository: RickRepositoryProtocol
    private let character: CharacterDomainModel

    required init(
        repository: RickRepositoryProtocol,
        character: CharacterDomainModel
    ) {
        self.repository = repository
        self.character = character
    }

    func getCharacter() -> CharacterDomainModel {
        return character
    }
    
    func favCharacter() -> AnyPublisher<CharacterDomainModel, any Error> {
        return repository.favCharacter(by: character.id)
    }
}
