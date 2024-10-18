//
//  AppRouterImpl.swift
//  Monterey
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Presentation
import UIKit

final class AppRouterImpl: AppRouter {
    func routeToMovieDetails(from sourceViewController: UIViewController, dependency: MovieDetailsViewModel.Dependency) {
        let destinationViewController = MovieDetailsScene.create(dependency: dependency)
        sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func routeToMovieSearch(from sourceViewController: UIViewController) {
        let destinationViewController = MovieSearchScene.create()
        sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func routeToFavorites(from sourceViewController: UIViewController) {
        let destinationViewController = FavoritesScene.create()
        sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
