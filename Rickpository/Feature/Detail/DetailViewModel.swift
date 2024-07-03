//
//  DetailViewModel.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = DetailRouter()
    private let detailUseCase: DetailUseCase
    
    @Published var character: CharacterModel
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var isError = false
    
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        character = detailUseCase.getCharacter()
    }
    
    func addFavorite() {
        detailUseCase.favCharacter()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case.failure: self.errorMessage = String(describing: completion)
                case .finished: self.isLoading = false
                }
            }, receiveValue: { char in
                self.character = char
            })
            .store(in: &cancellables)
    }
}
