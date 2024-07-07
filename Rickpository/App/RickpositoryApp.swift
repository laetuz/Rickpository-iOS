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

let characterUseCase: Interactor<
    Any,
    [CharacterDomainModel],
    GetCharactersRepository<
        GetCharactersLocalDataSource,
        GetCharactersRemoteDataSource,
        CharacterTransformer>
> = injection.provideCharacter()

@main
struct RickpositoryApp: App {
    let homeViewModel = GetListPresenter(_useCase: characterUseCase)
    let favViewModel = FavoriteViewModel(useCase: Injection.init().provideFavorite())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
                .environmentObject(favViewModel)
        }
    }
}
