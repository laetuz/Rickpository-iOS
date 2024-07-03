//
//  DetailView.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import SwiftUI
import CachedAsyncImage

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                loadingIndicator
            } else if viewModel.isLoading {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack() {
                        imageCategory
                        Spacer()
                        if viewModel.character.favorite {
                            CustomIcon(imageName: "heart.fill", title: "Favorited")
                                .onTapGesture {
                                    self.viewModel.addFavorite()
                                }
                        } else {
                            CustomIcon(imageName: "heart", title: "Favorite")
                                .onTapGesture {
                                    self.viewModel.addFavorite()
                                }
                        }
                        Spacer()
                        HStack {
                            content
                            Spacer()
                        }.padding([.leading, .trailing])
                        Spacer()
                    }
                    .padding()
                    
                }
            }
        }.navigationBarTitle(Text(self.viewModel.character.name), displayMode: .inline)
    }
}

extension DetailView {

    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }

    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: "error"
        ).offset(y: 80)
    }

    var imageCategory: some View {
        CachedAsyncImage(url: URL(string: self.viewModel.character.image)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.scaledToFit().frame(width: 250.0, height: 250.0, alignment: .center)
            .cornerRadius(12)
    }
    
    func mediumTitle(_ title: String) -> some View {
        Text(title).font(.headline)
    }
    
    var content: some View {
        let char = viewModel.character
        return VStack(alignment: .leading, spacing: 0) {

            mediumTitle("ID").padding([.top])
            Text("\(char.id)")
            mediumTitle("Name").padding([.top])
            Text("\(char.name)")
            mediumTitle("Species").padding([.top])
            Text("\(char.species)")
            mediumTitle("Status").padding([.top])
            Text("\(char.status)")
            mediumTitle("Origin").padding([.top])
            Text("\(char.origin?.name ?? "Unknown")")
        }
    }
}

//#Preview {
//    DetailView()
//}
