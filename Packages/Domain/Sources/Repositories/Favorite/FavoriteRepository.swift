//
//  FavoriteRepository.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Foundation

public protocol FavoriteRepository {
    func getFavorites() throws -> [Movie]
    func favorite(movie: Movie) throws
    func unfavorite(movie: Movie) throws
    func isFavorite(movie: Movie) throws -> Bool
}
