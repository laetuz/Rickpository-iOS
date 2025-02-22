//
//  HomeView.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import SwiftUI
import Character
import Core

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
//    @ObservedObject var viewModel: GetListPresenter<Any, CharacterDomainModel, Interactor<Any, [CharacterDomainModel], GetCharactersRepository<GetCharactersLocalDataSource, GetCharactersRemoteDataSource, CharacterTransformer>>>
    
    var body: some View {
        ZStack {
            if viewModel.isLoading { loadingIndicator }
            else if viewModel.isError { errorIndicator }
            else if viewModel.characters.isEmpty { emptyCategories }
            else { content }
        }.onAppear {
            if self.viewModel.characters.count == 0 {
                self.viewModel.getCharacters()//(request: nil)
            }
        }.navigationBarTitle(
            Text("Rickpository"),
            displayMode: .automatic
        )
    }
}

extension HomeView {
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
                    linkBuilder(for: char) {
                        CharacterRow(category: char)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    func linkBuilder<Content: View>(
        for character: CharacterDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().toDetailView(for: character)
        ) { content() }
    }
}

struct CustomEmptyView: View {
    var image: String
    var title: String

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 250)
            
            Text(title)
                .font(.system(.body, design: .rounded))
        }
    }
}
