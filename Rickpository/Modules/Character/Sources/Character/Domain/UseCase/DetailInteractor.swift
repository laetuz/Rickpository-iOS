//
//  DetailInteractor.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine
import Core

public protocol DetailUseCase {

    func getCharacter() -> CharacterDomainModel
    func favCharacter() -> AnyPublisher<CharacterDomainModel, Error>

}

public class DetailInteractor: DetailUseCase {

    private let repository: RickRepositoryProtocol
    private let character: CharacterDomainModel

    public init(
        repository: RickRepositoryProtocol,
        character: CharacterDomainModel
    ) {
        self.repository = repository
        self.character = character
    }

    public func getCharacter() -> CharacterDomainModel {
        return character
    }
    
    public func favCharacter() -> AnyPublisher<CharacterDomainModel, any Error> {
        return repository.favCharacter(by: character.id)
    }
}
