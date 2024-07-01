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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
        }
    }
}
