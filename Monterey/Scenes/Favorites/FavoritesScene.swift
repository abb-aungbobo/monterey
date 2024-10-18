//
//  FavoritesScene.swift
//  Monterey
//
//  Created by Aung Bo Bo on 04/05/2024.
//

import Data
import Domain
import Presentation

enum FavoritesScene {
    static func create() -> FavoritesViewController {
        let persistenceController: PersistenceController = PersistenceControllerImpl.shared
        let favoriteRepository: FavoriteRepository = FavoriteRepositoryImpl(persistenceController: persistenceController)
        let viewModel = FavoritesViewModel(favoriteRepository: favoriteRepository)
        let router: AppRouter = AppRouterImpl()
        let viewController = FavoritesViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
