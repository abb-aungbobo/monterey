//
//  MoviesPagingScene.swift
//  Monterey
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Data
import Domain
import Presentation

enum MoviesPagingScene {
    static func create() -> MoviesPagingViewController {
        let viewControllers = MoviesType.allCases.map(MoviesScene.create(type:))
        let router: AppRouter = AppRouterImpl()
        let viewController = MoviesPagingViewController(viewControllers: viewControllers, router: router)
        return viewController
    }
}
