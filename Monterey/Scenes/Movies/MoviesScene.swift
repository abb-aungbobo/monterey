//
//  MoviesScene.swift
//  Monterey
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Data
import Domain
import Presentation

enum MoviesScene {
    static func create(type: MoviesType) -> MoviesViewController {
        let networkController: NetworkController = NetworkControllerImpl.shared
        let movieRepository: MovieRepository = MovieRepositoryImpl(networkController: networkController)
        let viewModel = MoviesViewModel(moviesType: type, movieRepository: movieRepository)
        let router: AppRouter = AppRouterImpl()
        let viewController = MoviesViewController(viewModel: viewModel, router: router)
        viewController.title = type.title
        return viewController
    }
}
