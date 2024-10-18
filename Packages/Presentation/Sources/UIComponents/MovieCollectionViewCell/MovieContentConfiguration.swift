//
//  MovieContentConfiguration.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Domain
import UIKit

struct MovieContentConfiguration: UIContentConfiguration, Hashable {
    var poster: URL?
    var title: String?
    var voteAverage: String?
    var overview: String?
    
    func makeContentView() -> UIView & UIContentView {
        return MovieContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> MovieContentConfiguration {
        let updatedConfig = self
        return updatedConfig
    }
}

extension Movie {
    func toMovieContentConfiguration() -> MovieContentConfiguration {
        let notRated = "Not Rated"
        let userScore = String(format: "%.0f%% User Score", voteAverage * 10)
        let voteAverage = voteAverage == .zero ? notRated : userScore
        return MovieContentConfiguration(
            poster: posterURL,
            title: title,
            voteAverage: voteAverage,
            overview: overview
        )
    }
}
