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
import Favorite

final class Injection: NSObject {
    private let realm = try? Realm()
    
    func provideRepository() -> RickRepositoryProtocol {
        
        let local: LocalDataSourceCore = LocalDataSourceCore.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return RickRepository.sharedInstance(local, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repo = provideRepository()
        return HomeInteractor(repo: repo)
    }
    
    func provideDetail(character: CharacterDomainModel) -> DetailUseCase {
      let repository = provideRepository()
      return DetailInteractor(repository: repository, character: character)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repo = provideRepository()
        return FavoriteInteractor(repo: repo)
    }
    
    func provideFavoriteRepo() -> any FavoriteRepositoryProtocol {
        return FavoriteRepository(useCase: provideFavorite())
    }
}
