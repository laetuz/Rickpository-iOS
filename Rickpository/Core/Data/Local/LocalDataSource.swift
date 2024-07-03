//
//  LocalDataSource.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: AnyObject {
    func getCharacters() -> AnyPublisher<[CharacterEntity], Error>
    func addCharacters(from characters: [CharacterEntity]) -> AnyPublisher<Bool, Error>
    func addFavorite(by id: Int) -> AnyPublisher<CharacterEntity, Error>
}

final class LocalDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDb in
        return LocalDataSource(realm: realmDb)
    }
}

extension LocalDataSource: LocalDataSourceProtocol {
    func getCharacters() -> AnyPublisher<[CharacterEntity], Error> {
        return Future<[CharacterEntity], Error> { completion in
            if let realm = self.realm {
                let characters: Results<CharacterEntity> = {
                    realm.objects(CharacterEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(characters.toArray(ofType: CharacterEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addCharacters(from characters: [CharacterEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for character in characters {
                            realm.add(character, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addFavorite(by id: Int) -> AnyPublisher<CharacterEntity, Error> {
        return Future<CharacterEntity, Error> { completion in
            if let realm = self.realm, let charEntity = {
                realm.objects(CharacterEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try realm.write {
                        charEntity.setValue(!charEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(charEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self [index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
