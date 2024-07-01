//
//  DetailInteractor.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine

protocol DetailUseCase {

  func getCharacter() -> CharacterModel

}

class DetailInteractor: DetailUseCase {

  private let repository: RickRepositoryProtocol
  private let character: CharacterModel

  required init(
    repository: RickRepositoryProtocol,
    character: CharacterModel
  ) {
    self.repository = repository
    self.character = character
  }

  func getCharacter() -> CharacterModel {
    return character
  }
}
