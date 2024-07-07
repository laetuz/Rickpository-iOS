//
//  Injection.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import RealmSwift
import Core
import Character

final class Injection: NSObject {
    private let realm = try? Realm()
    
    func provideCharacter<U: UseCase>() -> U where U.Request == Any, U.Response == [CharacterDomainModel] {
        let local = GetCharactersLocalDataSource(realm: realm!)
        let remote = GetCharactersRemoteDataSource(endpoint: Endpoints.Gets.characters.url)
        let mapper = CharacterTransformer()
        
        let repo = GetCharactersRepository(localDataSource: local, remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repo) as! U
    }
    
    private func provideRepository() -> RickRepositoryProtocol {
        //let realm = try? Realm()
        
        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return RickRepository.sharedInstance(local, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repo = provideRepository()
        return HomeInteractor(repo: repo)
    }
    
    func provideDetail(character: CharacterModel) -> DetailUseCase {
      let repository = provideRepository()
      return DetailInteractor(repository: repository, character: character)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repo = provideRepository()
        return FavoriteInteractor(repo: repo)
    }
}
