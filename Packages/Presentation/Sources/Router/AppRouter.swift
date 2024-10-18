//
//  AppRouter.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import UIKit

public protocol AppRouter {
    func routeToMovieDetails(from sourceViewController: UIViewController, dependency: MovieDetailsViewModel.Dependency)
    func routeToMovieSearch(from sourceViewController: UIViewController)
    func routeToFavorites(from sourceViewController: UIViewController)
}
