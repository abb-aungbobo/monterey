//
//  MovieDetails.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Foundation

public struct MovieDetails {
    public let genres: [Genre]
    public let id: Int
    public let overview: String?
    public let posterPath: String?
    public let releaseDate: String
    public let runtime: Int
    public let title: String
    public let voteAverage: Double
    
    public var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    public init(
        genres: [Genre],
        id: Int,
        overview: String?,
        posterPath: String?,
        releaseDate: String,
        runtime: Int,
        title: String,
        voteAverage: Double
    ) {
        self.genres = genres
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.title = title
        self.voteAverage = voteAverage
    }
}

extension MovieDetails {
    public func toMovie() -> Movie {
        return Movie(
            id: id,
            posterPath: posterPath,
            title: title,
            voteAverage: voteAverage,
            overview: overview
        )
    }
}

extension MovieDetails {
    public static func fixture(
        genres: [Genre] = [],
        id: Int = 0,
        overview: String? = "",
        posterPath: String? = "",
        releaseDate: String = "",
        runtime: Int = 0,
        title: String = "",
        voteAverage: Double = 0.0
    ) -> MovieDetails {
        return MovieDetails(
            genres: genres,
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
