//
//  MoviesResponse.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Domain

struct MoviesResponse: Codable {
    let results: [MovieResponse]
}

extension MoviesResponse {
    func toMovies() -> Movies {
        return Movies(results: results.toMovies())
    }
}
