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
        let useCase: Interactor<
            Any,
            [CharacterDomainModel],
            GetCharactersRepository<GetCharactersLocalDataSource, GetCharactersRemoteDataSource, CharacterTransformer>> = Injection.init().provideCharacter()
      //  let detailUseCase = Injection.init().provideDetail(character: character)
        //let viewModel = DetailViewModel(detailUseCase: detailUseCase)
        let viewModel = GetListPresenter(_useCase: useCase)
        return DetailView(viewModel: viewModel, character: character)
    }
}
