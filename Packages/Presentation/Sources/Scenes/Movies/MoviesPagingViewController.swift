//
//  MoviesPagingViewController.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Parchment
import SnapKit
import UIKit

final public class MoviesPagingViewController: UIViewController {
    private var searchBarButtonItem: UIBarButtonItem!
    private var favoriteBarButtonItem: UIBarButtonItem!
    private var pagingViewController: PagingViewController!
    
    private let viewControllers: [UIViewController]
    private let router: AppRouter
    
    public init(viewControllers: [UIViewController], router: AppRouter) {
        self.viewControllers = viewControllers
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
    }
    
    private func configureHierarchy() {
        configureView()
        configureSearchBarButtonItem()
        configureFavoriteBarButtonItem()
        configureNavigationItem()
        configurePagingViewController()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSearchBarButtonItem() {
        let searchImage = UIImage(systemName: "magnifyingglass")
        let searchAction = UIAction { [weak self] action in
            guard let self else { return }
            self.router.routeToMovieSearch(from: self)
        }
        searchBarButtonItem = UIBarButtonItem(image: searchImage, primaryAction: searchAction)
    }
    
    private func configureFavoriteBarButtonItem() {
        let favoriteImage = UIImage(systemName: "heart")
        let favoriteAction = UIAction { [weak self] action in
            guard let self else { return }
            self.router.routeToFavorites(from: self)
        }
        favoriteBarButtonItem = UIBarButtonItem(image: favoriteImage, primaryAction: favoriteAction)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Monterey"
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItems = [searchBarButtonItem, favoriteBarButtonItem]
    }
    
    private func configurePagingViewController() {
        pagingViewController = PagingViewController(viewControllers: viewControllers)
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.dataSource = self
        pagingViewController.select(pagingItem: MoviesPagingItem(title: viewControllers[0].title, index: 0))
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 120, height: 48)
        pagingViewController.font = .preferredFont(forTextStyle: .subheadline)
        pagingViewController.indicatorColor = .systemPurple
        pagingViewController.borderColor = .clear
        pagingViewController.register(MoviesPagingCell.self, for: MoviesPagingItem.self)
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
        pagingViewController.didMove(toParent: self)
    }
}

// MARK: - PagingViewControllerDataSource
extension MoviesPagingViewController: PagingViewControllerDataSource {
    public func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return viewControllers.count
    }
    
    public func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return viewControllers[index]
    }
    
    public func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> any PagingItem {
        return MoviesPagingItem(title: viewControllers[index].title, index: index)
    }
}
