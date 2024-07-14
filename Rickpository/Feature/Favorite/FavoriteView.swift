//
//  FavoriteView.swift
//  Rickpository
//
//  Created by Ryo Martin on 03/07/24.
//

import SwiftUI
import Favorite

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading { loadingIndicator }
            else if viewModel.isError { errorIndicator }
            else if viewModel.characters.isEmpty { emptyCategories }
            else { content }
        }.onAppear {
            self.viewModel.getFavorite()
        }.navigationBarTitle(
            Text("Rickpository"),
            displayMode: .automatic
        )
    }
}

extension FavoriteView {
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(image: "assertSearchNotFound", title: viewModel.errorMessage)
    }
    
    var emptyCategories: some View {
      CustomEmptyView(
        image: "assetNoFavorite",
        title: "The character is empty"
      ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(
                self.viewModel.characters,
                id: \.id
            ) { char in
                ZStack {
                    self.viewModel.linkBuilder(for: char) {
                        CharacterRow(category: char)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(8)
            }
        }
    }
}

//#Preview {
//    FavoriteView()
//}
