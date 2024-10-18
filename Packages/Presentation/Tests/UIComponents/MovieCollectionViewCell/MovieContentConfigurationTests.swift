//
//  MovieContentConfigurationTests.swift
//  
//
//  Created by Aung Bo Bo on 05/05/2024.
//

import Domain
import XCTest
@testable import Presentation

final class MovieContentConfigurationTests: XCTestCase {
    func test_voteAverage_withZero_shouldBeNotRated() {
        let movie = Movie.fixture(voteAverage: 0.0)
        let configuration = movie.toMovieContentConfiguration()
        XCTAssertEqual(configuration.voteAverage, "Not Rated")
    }
    
    func test_voteAverage_withGreaterThanZero_shouldBeNumberPercentUserScore() {
        let movie = Movie.fixture(voteAverage: 9.7)
        let configuration = movie.toMovieContentConfiguration()
        XCTAssertEqual(configuration.voteAverage, "97% User Score")
    }
}
