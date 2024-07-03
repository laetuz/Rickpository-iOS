//
//  FavoriteRouter.swift
//  Rickpository
//
//  Created by Ryo Martin on 03/07/24.
//

import Foundation
import SwiftUI

class FavoriteRouter {
    func toDetailView(for character: CharacterModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(character: character)
        let viewModel = DetailViewModel(detailUseCase: detailUseCase)
        return DetailView(viewModel: viewModel)
    }
}
