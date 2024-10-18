//
//  MovieDetailsContentConfiguration.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Domain
import Foundation

struct MovieDetailsContentConfiguration {
    let genres: String
    let id: Int
    let overview: String?
    let posterURL: URL?
    let releaseDate: String
    let runtime: String
    let title: String
    let voteAverage: String
    
    var hideGenres: Bool {
        genres.isEmpty
    }
}

extension MovieDetails {
    func toMovieDetailsContentConfiguration() -> MovieDetailsContentConfiguration {
        let genres = genres.map(\.name).joined(separator: " • ")
        let runtime = runtime > 1 ? String(format: "%d mins", runtime) : String(format: "%d min", runtime)
        let notRated = "Not Rated"
        let userScore = String(format: "%.0f%% User Score", voteAverage * 10)
        let voteAverage = voteAverage == .zero ? notRated : userScore
        return MovieDetailsContentConfiguration(
            genres: genres,
            id: id,
            overview: overview,
            posterURL: posterURL,
            releaseDate: releaseDate,
            runtime: runtime,
            title: title,
            voteAverage: voteAverage
        )
    }
}
