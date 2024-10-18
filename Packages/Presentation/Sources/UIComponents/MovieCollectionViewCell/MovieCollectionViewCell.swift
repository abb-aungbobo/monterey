//
//  MovieCollectionViewCell.swift
//  
//
//  Created by Aung Bo Bo on 28/04/2024.
//


import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    var configuration: MovieContentConfiguration!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = MovieContentConfiguration().updated(for: state)
        newConfiguration.poster = configuration.poster
        newConfiguration.title = configuration.title
        newConfiguration.voteAverage = configuration.voteAverage
        newConfiguration.overview = configuration.overview
        contentConfiguration = newConfiguration
    }
}
