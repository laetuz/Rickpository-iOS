//
//  ContentView.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import SwiftUI
import Realm
import Core
import Character

struct ContentView: View {
    @EnvironmentObject var homeViewModel: GetListPresenter<Any, CharacterDomainModel, Interactor<Any, [CharacterDomainModel], GetCharactersRepository<GetCharactersLocalDataSource, GetCharactersRemoteDataSource, CharacterTransformer>>>
   // @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var favViewModel: FavoriteViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(viewModel: homeViewModel)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            NavigationStack {
                AboutView()
            }.tabItem {
                TabItem(imageName: "person", title: "About")
            }
            NavigationStack {
                FavoriteView(viewModel: favViewModel)
            }.tabItem {
                TabItem(imageName: "star", title: "Favorite")
            }

        }
    }
}

//#Preview {
//    ContentView()
//}

struct TabItem: View {

  var imageName: String
  var title: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }

}
