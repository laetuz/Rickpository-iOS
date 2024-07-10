//
//  LocalDataSource.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import RealmSwift
import Combine
import Core

public protocol LocalDataSourceProtocol: AnyObject {
    func getCharacters() -> AnyPublisher<[CharacterEntity], Error>
    func addCharacters(from characters: [CharacterEntity]) -> AnyPublisher<Bool, Error>
    func addFavorite(by id: Int) -> AnyPublisher<CharacterEntity, Error>
    func getFavoriteCharacters() -> AnyPublisher<[CharacterEntity], Error>
}

public final class LocalDataSourceCore: NSObject {
    let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    public static let sharedInstance: (Realm?) -> LocalDataSourceCore = { realmDb in
        return LocalDataSourceCore(realm: realmDb)
    }
}

extension LocalDataSourceCore: LocalDataSourceProtocol {
    public func getCharacters() -> AnyPublisher<[CharacterEntity], Error> {
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
    
    public func addCharacters(from characters: [CharacterEntity]) -> AnyPublisher<Bool, Error> {
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
    
    public func addFavorite(by id: Int) -> AnyPublisher<CharacterEntity, Error> {
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
    
    public func getFavoriteCharacters() -> AnyPublisher<[CharacterEntity], Error> {
        return Future<[CharacterEntity], Error> { completion in
            if let realm = self.realm {
                let entities = {
                    realm.objects(CharacterEntity.self)
                        .filter("favorite = \(true)")
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(entities.toArray(ofType: CharacterEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension Results {
    public func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self [index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
