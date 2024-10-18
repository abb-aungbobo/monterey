//
//  MovieEntity.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Domain
import Foundation
import RealmSwift

class MovieEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var posterPath: String?
    @Persisted var title: String
    @Persisted var voteAverage: Double
    @Persisted var overview: String?
}

extension MovieEntity {
    func toMovie() -> Movie {
        return Movie(
            id: id,
            posterPath: posterPath,
            title: title,
            voteAverage: voteAverage,
            overview: overview
        )
    }
}

extension Array where Element == MovieEntity {
    func toMovies() -> [Movie] {
        return map { entity in
            return entity.toMovie()
        }
    }
}

extension Movie {
    func toMovieEntity() -> MovieEntity {
        let entity = MovieEntity()
        entity.id = id
        entity.posterPath = posterPath
        entity.title = title
        entity.voteAverage = voteAverage
        entity.overview = overview
        return entity
    }
}
