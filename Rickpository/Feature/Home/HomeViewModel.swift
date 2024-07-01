//
//  HomeViewModel.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let useCase: HomeUseCase
    
    @Published var characters: [CharacterModel] = []
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var isError = false
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getCharacters() {
        isLoading = true
        useCase.getCharacters()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("masuk")
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished: self.isLoading = false
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
