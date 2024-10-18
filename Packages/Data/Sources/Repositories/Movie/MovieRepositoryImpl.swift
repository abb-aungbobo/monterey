//
//  MovieRepositoryImpl.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Domain

final public class MovieRepositoryImpl: MovieRepository {
    private let networkController: NetworkController
    
    public init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    public func getMovies(type: MoviesType) async throws -> Movies {
        let endpoint: MovieEndpoint = .movies(type.rawValue)
        let response: MoviesResponse = try await networkController.request(for: endpoint)
        return response.toMovies()
    }
    
    public func getMovieDetails(id: Int) async throws -> MovieDetails {
        let endpoint: MovieEndpoint = .movieDetails(id)
        let response: MovieDetailsResponse = try await networkController.request(for: endpoint)
        return response.toMovieDetails()
    }
    
    public func getSimilarMovies(id: Int) async throws -> Movies {
        let endpoint: MovieEndpoint = .similarMovies(id)
        let response: MoviesResponse = try await networkController.request(for: endpoint)
        return response.toMovies()
    }
}
