//
//  MovieDetailsResponse.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Domain

struct MovieDetailsResponse: Codable {
    let genres: [GenreResponse]
    let id: Int
    let overview: String?
    let posterPath: String?
    let releaseDate: String
    let runtime: Int
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case genres
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title
        case voteAverage = "vote_average"
    }
}

extension MovieDetailsResponse {
    func toMovieDetails() -> MovieDetails {
        return MovieDetails(
            genres: genres.toGenres(),
            id: id,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate,
            runtime: runtime,
            title: title,
            voteAverage: voteAverage
        )
    }
}
