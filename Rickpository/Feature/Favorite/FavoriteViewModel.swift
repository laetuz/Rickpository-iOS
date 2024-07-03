//
//  FavoriteViewModel.swift
//  Rickpository
//
//  Created by Ryo Martin on 03/07/24.
//

import SwiftUI
import Combine

class FavoriteViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    private let useCase: FavoriteUseCase
    
    @Published var characters: [CharacterModel] = []
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var isError = false
    
    init(useCase: FavoriteUseCase) {
        self.useCase = useCase
    }
    
    func getFavorite() {
        isLoading = true
        useCase.getCharacters()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    self.isError = true
                }
            }, receiveValue: { char in
                self.characters = char
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for char: CharacterModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.toDetailView(for: char)) {
            content()
        }
    }
}
