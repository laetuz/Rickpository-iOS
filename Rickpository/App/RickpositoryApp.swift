//
//  RickpositoryApp.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import SwiftUI
import Core
import Character

let injection = Injection()

//let characterUseCase: Interactor<
//    Any,
//    [CharacterDomainModel],
//    GetCharactersRepository<
//        GetCharactersLocalDataSource,
//        GetCharactersRemoteDataSource,
//        CharacterTransformer>
//> = injection.provideCharacter()

@main
struct RickpositoryApp: App {
    let homeViewModel = HomeViewModel(useCase: Injection.init().provideHome()) //GetListPresenter(_useCase: characterUseCase)
    let favViewModel = FavoriteViewModel(favoriteRepo: Injection.init().provideFavoriteRepo())
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
                .environmentObject(favViewModel)
        }
    }
}
