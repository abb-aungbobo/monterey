//
//  MovieDetailsContentConfigurationTests.swift
//  
//
//  Created by Aung Bo Bo on 05/05/2024.
//

import Domain
import XCTest
@testable import Presentation

final class MovieDetailsContentConfigurationTests: XCTestCase {
    func test_runtime_withOne_shouldBeOneMin() {
        let movieDetails = MovieDetails.fixture(runtime: 1)
        let configuration = movieDetails.toMovieDetailsContentConfiguration()
        XCTAssertEqual(configuration.runtime, "1 min")
    }
    
    func test_runtime_withTwo_shouldBeTwoMins() {
        let movieDetails = MovieDetails.fixture(runtime: 2)
        let configuration = movieDetails.toMovieDetailsContentConfiguration()
        XCTAssertEqual(configuration.runtime, "2 mins")
    }
    
    func test_voteAverage_withZero_shouldBeNotRated() {
        let movieDetails = MovieDetails.fixture(voteAverage: 0.0)
        let configuration = movieDetails.toMovieDetailsContentConfiguration()
        XCTAssertEqual(configuration.voteAverage, "Not Rated")
    }
    
    func test_voteAverage_withGreaterThanZero_shouldBeNumberPercentUserScore() {
        let movieDetails = MovieDetails.fixture(voteAverage: 9.7)
        let configuration = movieDetails.toMovieDetailsContentConfiguration()
        XCTAssertEqual(configuration.voteAverage, "97% User Score")
    }
}
