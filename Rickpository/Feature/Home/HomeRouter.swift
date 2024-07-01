//
//  HomeRouter.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import SwiftUI

class HomeRouter {
    func toDetailView(for character: CharacterModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(character: character)
        let viewModel = DetailViewModel(detailUseCase: detailUseCase)
        return DetailView(viewModel: viewModel)
    }
}
