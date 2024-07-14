//
//  FavoriteViewModel.swift
//  Rickpository
//
//  Created by Ryo Martin on 09/07/24.
//

import SwiftUI
import Combine
import Character
import Core
import Favorite

class FavoriteViewModel: ObservableObject {
    public var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    
    private let favoriteRepo: any FavoriteRepositoryProtocol
    
    @Published public var characters: [CharacterDomainModel] = []
    @Published public var errorMessage = ""
    @Published public var isLoading = false
    @Published public var isError = false
    
    init(favoriteRepo: any FavoriteRepositoryProtocol) {
        self.favoriteRepo = favoriteRepo
        
//        isLoading = favoriteRepo.isLoading
//        isError = favoriteRepo.isError
//        characters = favoriteRepo.characters
    }
    
    public func getFavorite() {
        isLoading = true
        favoriteRepo.getFavorite()

       // favoriteRepo.characters.publisher.receive(on: RunLoop.main).assign(to: \.characters, on: self).store(in: &<#T##RangeReplaceableCollection#>)
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
    
    public func linkBuilder<Content: View>(
        for char: CharacterDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.toDetailView(for: char)) {
            content()
        }
    }
}
