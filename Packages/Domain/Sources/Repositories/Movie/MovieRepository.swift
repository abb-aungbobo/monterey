//
//  MovieRepository.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Foundation

public protocol MovieRepository {
    func getMovies(type: MoviesType) async throws -> Movies
    func getMovieDetails(id: Int) async throws -> MovieDetails
    func getSimilarMovies(id: Int) async throws -> Movies
}
