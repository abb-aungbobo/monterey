//
//  MovieRepositoryStub.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Domain
import Foundation
import Utilities

final public class MovieRepositoryStub: MovieRepository {
    public init () {}
    
    public func getMovies(type: MoviesType) async throws -> Movies {
        let response: MoviesResponse = try JSON.decode(from: "movies", bundle: .data)
        return response.toMovies()
    }
    
    public func getMovieDetails(id: Int) async throws -> MovieDetails {
        let response: MovieDetailsResponse = try JSON.decode(from: "details", bundle: .data)
        return response.toMovieDetails()
    }
    
    public func getSimilarMovies(id: Int) async throws -> Movies {
        let response: MoviesResponse = try JSON.decode(from: "similar", bundle: .data)
        return response.toMovies()
    }
}
