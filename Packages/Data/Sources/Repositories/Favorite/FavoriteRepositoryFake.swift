//
//  FavoriteRepositoryFake.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Core
import Domain
import Foundation
import Utilities

final public class FavoriteRepositoryFake: FavoriteRepository {
    private var favorites: [Movie] = []
    
    public init() {
        let response: MoviesResponse = try! JSON.decode(from: "movies", bundle: .data)
        let movies = response.toMovies()
        favorites = movies.results
    }
    
    public func getFavorites() throws -> [Movie] {
        return favorites
    }
    
    public func favorite(movie: Movie) throws {
        favorites.append(movie)
    }
    
    public func unfavorite(movie: Movie) throws {
        let key = movie.id
        guard let entity = favorites.first(where: { $0.id == key }), let index = favorites.firstIndex(of: entity) else {
            throw AppError.generic
        }
        favorites.remove(at: index)
    }
    
    public func isFavorite(movie: Movie) throws -> Bool {
        let key = movie.id
        let entity = favorites.first(where: { $0.id == key })
        return entity != nil
    }
}
