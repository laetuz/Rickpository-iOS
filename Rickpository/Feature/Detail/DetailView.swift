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
            VStack {
              imageCategory
              spacer
              content
              spacer
            }.padding()
          }
        }
      }.onAppear {
      //  if self.viewModel.meals.count == 0 {
       //   self.presenter.getMeals()
     //   }
      }//.navigationBarTitle(Text(self.presenter.category.title), displayMode: .large)
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }

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
    }
    
    var content: some View {
        var char = viewModel.character
        return VStack(alignment: .leading, spacing: 0) {
            Text("\(char.id)")
            Text("\(char.name)")
            Text("\(char.species)")
            Text("\(char.status)")
        }
    }
}

//#Preview {
//    DetailView()
//}
