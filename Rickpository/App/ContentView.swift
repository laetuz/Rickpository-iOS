//
//  ContentView.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import SwiftUI
import Realm

struct ContentView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var favViewModel: FavoriteViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(viewModel: homeViewModel)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            NavigationStack {
                FavoriteView(viewModel: favViewModel)
            }.tabItem {
                TabItem(imageName: "star", title: "Favorite")
            }
        }
    }
}

#Preview {
    ContentView()
}

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
