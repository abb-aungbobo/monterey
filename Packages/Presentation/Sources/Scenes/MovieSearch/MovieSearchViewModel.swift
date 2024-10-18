//
//  MovieSearchViewModel.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Combine
import Core
import Domain
import Foundation

final public class MovieSearchViewModel {
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
        
    public let query = PassthroughSubject<String, Never>()
    public let state = CurrentValueSubject<State, Never>(.idle)
    public var cancellables: Set<AnyCancellable> = []
    
    public private(set) var movies: [Movie] = []
    
    private let searchRepository: SearchRepository
    
    public init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
        
        bind()
    }
    
    private func bind() {
        query
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self else { return }
                
                let query = text.trimmingCharacters(in: .whitespaces)
                guard !query.isEmpty else {
                    self.movies = []
                    self.state.send(.succeeded)
                    return
                }
                
                Task {
                    await self.searchMovies(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    public func searchMovies(query: String) async {
        do {
            let movies = try await searchRepository.searchMovies(query: query)
            self.movies = movies.results
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
