//
//  FavoritesViewModel.swift
//  
//
//  Created by Aung Bo Bo on 04/05/2024.
//

import Combine
import Core
import Domain

final public class FavoritesViewModel {
    public enum State: Equatable {
        case idle
        case failed(AppError)
        case succeeded
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.failed, .failed): return true
            case (.succeeded, .succeeded): return true
            default: return false
            }
        }
    }
        
    let title = "Favorites"
    public let state = CurrentValueSubject<State, Never>(.idle)
    public var cancellables: Set<AnyCancellable> = []
    
    public private(set) var movies: [Movie] = []
    
    private let favoriteRepository: FavoriteRepository
    
    public init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
    public func getFavorites() {
        do {
            let movies = try favoriteRepository.getFavorites()
            self.movies = movies
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}

