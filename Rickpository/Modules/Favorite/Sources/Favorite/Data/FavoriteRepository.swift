//
//  FavoriteViewModel.swift
//  Rickpository
//
//  Created by Ryo Martin on 03/07/24.
//

//import SwiftUI
import Combine
import Character
import Core
import Foundation

public protocol FavoriteRepositoryProtocol: ObservableObject {
    var characters: [CharacterDomainModel] {get}
    var errorMessage: String { get }
    var isLoading: Bool { get }
    var isError: Bool { get }
    
    func getFavorite() -> AnyPublisher<[CharacterDomainModel], Error>
}

public class FavoriteRepository: ObservableObject, FavoriteRepositoryProtocol {
    public var cancellables: Set<AnyCancellable> = []
    private let useCase: FavoriteUseCase
    
    @Published public var characters: [CharacterDomainModel] = []
    @Published public var errorMessage = ""
    @Published public var isLoading = false
    @Published public var isError = false
    
    public init(useCase: FavoriteUseCase) {
        self.useCase = useCase
    }
    
    public func getFavorite() -> AnyPublisher<[CharacterDomainModel], Error> {
        isLoading = true
        return useCase.getCharacters().handleEvents(receiveSubscription: {[weak self] _ in
            self?.isLoading = true
        }, receiveCompletion: { comletion in
            switch comletion {
            case.finished: self.isLoading = false
            case.failure(let failure):  self.errorMessage = failure.localizedDescription; self.isError = true
            }
        }).eraseToAnyPublisher()
        
        
//        useCase.getCharacters()
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    self.isLoading = false
//                case .failure(let failure):
//                    self.errorMessage = failure.localizedDescription
//                    self.isError = true
//                }
//            }, receiveValue: { char in
//                self.characters = char
//            })
//            .store(in: &cancellables)
    }
}
