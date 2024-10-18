//
//  SearchRepositoryImpl.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Domain

final public class SearchRepositoryImpl: SearchRepository {
    private let networkController: NetworkController
    
    public init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    public func searchMovies(query: String) async throws -> Movies {
        let endpoint: SearchEndpoint = .searchMovies(query)
        let response: MoviesResponse = try await networkController.request(for: endpoint)
        return response.toMovies()
    }
}
