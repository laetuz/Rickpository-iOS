//
//  Injection.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    private func provideRepository() -> RickRepositoryProtocol {
        let realm = try? Realm()
        
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
