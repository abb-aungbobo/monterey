//
//  SearchRepository.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Foundation

public protocol SearchRepository {
    func searchMovies(query: String) async throws -> Movies
}
