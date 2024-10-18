//
//  FavoritesViewModelTests.swift
//  MontereyTests
//
//  Created by Aung Bo Bo on 06/05/2024.
//

import Data
import Domain
import Presentation
import XCTest

final class FavoritesViewModelTests: XCTestCase {
    private var sut: FavoritesViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let favoriteRepository: FavoriteRepository = FavoriteRepositoryFake()
        sut = FavoritesViewModel(favoriteRepository: favoriteRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_state_whenGetFavorites_shouldBeIdleAndSucceeded() {
        let expected: [FavoritesViewModel.State] = [.idle, .succeeded]
        var results: [FavoritesViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        sut.getFavorites()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_movies_whenGetFavorites_shouldNotBeEmpty() {
        sut.getFavorites()
        XCTAssertFalse(sut.movies.isEmpty)
    }
}
