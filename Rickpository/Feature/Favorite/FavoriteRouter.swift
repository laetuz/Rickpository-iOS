//
//  FavoriteRouter.swift
//  Rickpository
//
//  Created by Ryo Martin on 03/07/24.
//

import Foundation
import SwiftUI
import Core
import Character

class FavoriteRouter {
    func toDetailView(for character: CharacterDomainModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(character: character)
        let viewModel = DetailViewModel(detailUseCase: detailUseCase)
        return DetailView(viewModel: viewModel, character: character)
    }
}
