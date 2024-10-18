//
//  GenreResponse.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Domain

struct GenreResponse: Codable {
    let name: String
}

extension GenreResponse {
    func toGenre() -> Genre {
        return Genre(name: name)
    }
}

extension Array where Element == GenreResponse {
    func toGenres() -> [Genre] {
        return map { response in
            return response.toGenre()
        }
    }
}
