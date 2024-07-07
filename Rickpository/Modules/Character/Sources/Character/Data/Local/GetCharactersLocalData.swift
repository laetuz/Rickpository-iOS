//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetCharactersLocalDataSource: LocalDataSource {
    public func update(id: Int, entity: CharacterEntityModule) -> AnyPublisher<Bool, any Error> {
        fatalError()
    }
    

  public typealias Request = Any

  public typealias Response = CharacterEntityModule

  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func list(request: Any?) -> AnyPublisher<[CharacterEntityModule], Error> {
    return Future<[CharacterEntityModule], Error> { completion in
      let characters: Results<CharacterEntityModule> = {
        self.realm.objects(CharacterEntityModule.self)
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(characters.toArray(ofType: CharacterEntityModule.self)))

    }.eraseToAnyPublisher()
  }

  public func add(entities: [CharacterEntityModule]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try self.realm.write {
          for character in entities {
            self.realm.add(character, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }

    }.eraseToAnyPublisher()
  }

  public func get(id: String) -> AnyPublisher<CharacterEntityModule, Error> {
    fatalError()
  }

}
