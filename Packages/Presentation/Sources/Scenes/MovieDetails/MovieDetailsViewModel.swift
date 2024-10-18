//
//  MovieDetailsViewModel.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Combine
import Core
import Domain
import UIKit

final public class MovieDetailsViewModel {
    public struct Dependency {
        let id: Int
        
        public init(id: Int) {
            self.id = id
        }
    }
    
    public enum State: Equatable {
        case idle
        case loading
        case failed(AppError)
        case succeeded
        case favorite
        case unfavorite
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.loading, .loading): return true
            case (.failed, .failed): return true
            case (.succeeded, .succeeded): return true
            case (.favorite, .favorite): return true
            case (.unfavorite, .unfavorite): return true
            default: return false
            }
        }
    }
    
    public let state = CurrentValueSubject<State, Never>(.idle)
    public var cancellables: Set<AnyCancellable> = []
    
    public private(set) var movieDetails: MovieDetails?
    public private(set) var similarMovies: [Movie] = []
    
    private var movie: Movie? {
        movieDetails?.toMovie()
    }
    
    public var isFavorite: Bool {
        guard let movie else { return false }
        do {
            return try favoriteRepository.isFavorite(movie: movie)
        } catch {
            return false
        }
    }
    
    public var favoriteImage: UIImage? {
        isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    enum Section: Int, CaseIterable {
        case movieDetails
        case similarMovies
        
        init?(rawValue: Int) {
            switch rawValue {
            case 0: self = .movieDetails
            case 1: self = .similarMovies
            default: return nil
            }
        }
    }
    
    var numberOfSections: Int {
        return Section.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .movieDetails: return 0
        case .similarMovies: return similarMovies.count
        }
    }
    
    private let dependency: Dependency
    private let movieRepository: MovieRepository
    private let favoriteRepository: FavoriteRepository
    
    public init(
        dependency: Dependency,
        movieRepository: MovieRepository,
        favoriteRepository: FavoriteRepository
    ) {
        self.dependency = dependency
        self.movieRepository = movieRepository
        self.favoriteRepository = favoriteRepository
    }
    
    @MainActor
    public func getMovieDetails() async {
        state.send(.loading)
        do {
            async let movieDetails = try movieRepository.getMovieDetails(id: dependency.id)
            async let similarMovies = try movieRepository.getSimilarMovies(id: dependency.id)

            let (movieDetailsResult, similarMoviesResult) = try await (movieDetails, similarMovies)
            
            self.movieDetails = movieDetailsResult
            self.similarMovies = similarMoviesResult.results
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    public func favorite() {
        guard let movie else { return }
        do {
            try favoriteRepository.favorite(movie: movie)
            state.send(.favorite)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    public func unfavorite() {
        guard let movie else { return }
        do {
            try favoriteRepository.unfavorite(movie: movie)
            state.send(.unfavorite)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
