//
//  MovieDetailsViewModelTests.swift
//  MontereyTests
//
//  Created by Aung Bo Bo on 06/05/2024.
//

import Data
import Domain
import Presentation
import XCTest

final class MovieDetailsViewModelTests: XCTestCase {
    private var sut: MovieDetailsViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let dependency = MovieDetailsViewModel.Dependency(id: .zero)
        let movieRepository: MovieRepository = MovieRepositoryStub()
        let favoriteRepository: FavoriteRepository = FavoriteRepositoryFake()
        sut = MovieDetailsViewModel(dependency: dependency, movieRepository: movieRepository, favoriteRepository: favoriteRepository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_state_whenGetMovieDetails_shouldBeIdleAndLoadingAndSucceeded() async {
        let expected: [MovieDetailsViewModel.State] = [.idle, .loading, .succeeded]
        var results: [MovieDetailsViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.getMovieDetails()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_state_whenGetMovieDetailsAndFavorite_shouldBeIdleAndLoadingAndSucceededAndFavorite() async {
        let expected: [MovieDetailsViewModel.State] = [.idle, .loading, .succeeded, .favorite]
        var results: [MovieDetailsViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.getMovieDetails()
        sut.favorite()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_state_whenGetMovieDetailsAndUnfavorite_shouldBeIdleAndLoadingAndSucceededAndUnfavorite() async {
        let expected: [MovieDetailsViewModel.State] = [.idle, .loading, .succeeded, .unfavorite]
        var results: [MovieDetailsViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.getMovieDetails()
        sut.unfavorite()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_movieDetails_whenGetMovieDetails_shouldNotBeNil() async {
        await sut.getMovieDetails()
        XCTAssertNotNil(sut.movieDetails)
    }
    
    func test_similarMovies_whenGetMovieDetails_shouldNotBeEmpty() async {
        await sut.getMovieDetails()
        XCTAssertFalse(sut.similarMovies.isEmpty)
    }
    
    func test_isFavorite_whenGetMovieDetails_shouldBeTrue() async {
        await sut.getMovieDetails()
        XCTAssertTrue(sut.isFavorite)
    }
    
    func test_isFavorite_whenGetMovieDetailsAndUnfavorite_shouldBeFalse() async {
        await sut.getMovieDetails()
        sut.unfavorite()
        XCTAssertFalse(sut.isFavorite)
    }
    
    func test_favoriteImage_whenGetMovieDetails_shouldBeHeartFill() async {
        await sut.getMovieDetails()
        XCTAssert(sut.favoriteImage == UIImage(systemName: "heart.fill"))
    }
    
    func test_favoriteImage_whenGetMovieDetailsAndUnfavorite_shouldBeHeart() async {
        await sut.getMovieDetails()
        sut.unfavorite()
        XCTAssert(sut.favoriteImage == UIImage(systemName: "heart"))
    }
}
