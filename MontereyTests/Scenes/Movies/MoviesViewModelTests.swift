//
//  MoviesViewModelTests.swift
//  MontereyTests
//
//  Created by Aung Bo Bo on 06/05/2024.
//

import Data
import Domain
import Presentation
import XCTest

final class MoviesViewModelTests: XCTestCase {
    private var sut: MoviesViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let movieRepository: MovieRepository = MovieRepositoryStub()
        sut = MoviesViewModel(moviesType: .nowPlaying, movieRepository: movieRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_state_whenGetMovies_shouldBeIdleAndLoadingAndSucceeded() async {
        let expected: [MoviesViewModel.State] = [.idle, .loading, .succeeded]
        var results: [MoviesViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.getMovies()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_movies_whenGetMovies_shouldNotBeEmpty() async {
        await sut.getMovies()
        XCTAssertFalse(sut.movies.isEmpty)
    }
}
