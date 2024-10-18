//
//  MovieDetailsScene.swift
//  Monterey
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Data
import Domain
import Presentation

enum MovieDetailsScene {
    static func create(dependency: MovieDetailsViewModel.Dependency) -> MovieDetailsViewController {
        let networkController: NetworkController = NetworkControllerImpl.shared
        let persistenceController: PersistenceController = PersistenceControllerImpl.shared
        let movieRepository: MovieRepository = MovieRepositoryImpl(networkController: networkController)
        let favoriteRepository: FavoriteRepository = FavoriteRepositoryImpl(persistenceController: persistenceController)
        let viewModel = MovieDetailsViewModel(
            dependency: dependency,
            movieRepository: movieRepository,
            favoriteRepository: favoriteRepository
        )
        let router: AppRouter = AppRouterImpl()
        let viewController = MovieDetailsViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
