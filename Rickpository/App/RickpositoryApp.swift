//
//  RickpositoryApp.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import SwiftUI

@main
struct RickpositoryApp: App {
    let homeViewModel = HomeViewModel(useCase: Injection.init().provideHome())
    let favViewModel = FavoriteViewModel(useCase: Injection.init().provideFavorite())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
                .environmentObject(favViewModel)
        }
    }
}
