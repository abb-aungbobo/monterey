//
//  MovieSearchScene.swift
//  Monterey
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Data
import Domain
import Presentation

enum MovieSearchScene {
    static func create() -> MovieSearchViewController {
        let networkController: NetworkController = NetworkControllerImpl.shared
        let searchRepository: SearchRepository = SearchRepositoryImpl(networkController: networkController)
        let viewModel = MovieSearchViewModel(searchRepository: searchRepository)
        let router: AppRouter = AppRouterImpl()
        let viewController = MovieSearchViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
