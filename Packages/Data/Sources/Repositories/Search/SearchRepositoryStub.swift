//
//  SearchRepositoryStub.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Domain
import Foundation
import Utilities

final public class SearchRepositoryStub: SearchRepository {
    public init () {}
    
    public func searchMovies(query: String) async throws -> Movies {
        let response: MoviesResponse = try JSON.decode(from: "search", bundle: .data)
        return response.toMovies()
    }
}
