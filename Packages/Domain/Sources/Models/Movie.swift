//
//  Movie.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Foundation

public struct Movie: Hashable {
    public let id: Int
    public let posterPath: String?
    public let title: String
    public let voteAverage: Double
    public let overview: String?
    
    public var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    public init(
        id: Int,
        posterPath: String?,
        title: String,
        voteAverage: Double,
        overview: String?
    ) {
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
    }
}

extension Movie {
    public static func fixture(
        id: Int = 0,
        posterPath: String? = "",
        title: String = "",
        voteAverage: Double = 0.0,
        overview: String? = ""
    ) -> Movie {
        return Movie(
            id: id,
            posterPath: posterPath,
            title: title,
            voteAverage: voteAverage,
            overview: overview
        )
    }
}
