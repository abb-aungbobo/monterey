//
//  MoviesViewModel.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Combine
import Core
import Domain

final public class MoviesViewModel {
    public enum State: Equatable {
        case idle
        case loading
        case failed(AppError)
        case succeeded
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.loading, .loading): return true
            case (.failed, .failed): return true
            case (.succeeded, .succeeded): return true
            default: return false
            }
        }
    }
    
    public let state = CurrentValueSubject<State, Never>(.idle)
    public var cancellables: Set<AnyCancellable> = []
    
    public private(set) var movies: [Movie] = []
    
    private let moviesType: MoviesType
    private let movieRepository: MovieRepository
    
    public init(moviesType: MoviesType, movieRepository: MovieRepository) {
        self.moviesType = moviesType
        self.movieRepository = movieRepository
    }
    
    @MainActor
    public func getMovies() async {
        state.send(.loading)
        do {
            let movies = try await movieRepository.getMovies(type: moviesType)
            self.movies = movies.results
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
