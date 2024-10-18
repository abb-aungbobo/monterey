//
//  FavoriteRepositoryImpl.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Core
import Domain

final public class FavoriteRepositoryImpl: FavoriteRepository {
    private let persistenceController: PersistenceController
    
    public init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    public func getFavorites() throws -> [Movie] {
        let entities: [MovieEntity] = try persistenceController.get()
        return entities.toMovies()
    }
    
    public func favorite(movie: Movie) throws {
        let entity = movie.toMovieEntity()
        try persistenceController.add(entity: entity)
    }
    
    public func unfavorite(movie: Movie) throws {
        let key = movie.id
        guard let entity = try persistenceController.get(ofType: MovieEntity.self, forPrimaryKey: key) else {
            throw AppError.generic
        }
        try persistenceController.delete(entity: entity)
    }
    
    public func isFavorite(movie: Movie) throws -> Bool {
        let key = movie.id
        let entity = try persistenceController.get(ofType: MovieEntity.self, forPrimaryKey: key)
        return entity != nil
    }
}
