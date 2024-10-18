//
//  MovieDetailsViewController.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Core
import SnapKit
import UIKit

final public class MovieDetailsViewController: BaseViewController {
    private var favoriteBarButtonItem: UIBarButtonItem!
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let viewModel: MovieDetailsViewModel
    private let router: AppRouter
    
    public init(viewModel: MovieDetailsViewModel, router: AppRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        bind()
        
        Task {
            await viewModel.getMovieDetails()
        }
    }
    
    private func configureHierarchy() {
        configureView()
        configureFavoriteBarButtonItem()
        configureNavigationItem()
        configureTableView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureFavoriteBarButtonItem() {
        let favoriteAction = UIAction { [weak self] action in
            guard let self else { return }
            if self.viewModel.isFavorite {
                self.viewModel.unfavorite()
            } else {
                self.viewModel.favorite()
            }
        }
        favoriteBarButtonItem = UIBarButtonItem(primaryAction: favoriteAction)
    }
    
    private func configureNavigationItem() {
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.register(
            MovieTableViewCell.self,
            forCellReuseIdentifier: MovieTableViewCell.identifier
        )
        tableView.register(
            MovieDetailsHeaderView.self,
            forHeaderFooterViewReuseIdentifier: MovieDetailsHeaderView.identifier
        )
        tableView.register(
            SimilarMoviesHeaderView.self,
            forHeaderFooterViewReuseIdentifier: SimilarMoviesHeaderView.identifier
        )
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: MovieDetailsViewModel.State) {
        switch state {
        case .idle:
            clearContentUnavailableConfiguration()
        case .loading:
            showLoading()
        case let .failed(error):
            clearContentUnavailableConfiguration()
            showErrorAlert(error: error)
        case .succeeded:
            clearContentUnavailableConfiguration()
            favoriteBarButtonItem.image = viewModel.favoriteImage
            navigationItem.rightBarButtonItem = favoriteBarButtonItem
            tableView.reloadData()
        case .favorite, .unfavorite:
            favoriteBarButtonItem.image = viewModel.favoriteImage
        }
    }
}

// MARK: - UITableViewDataSource
extension MovieDetailsViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MovieDetailsViewModel.Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .movieDetails:
            return UITableViewCell()
        case .similarMovies:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieTableViewCell.identifier,
                for: indexPath
            ) as! MovieTableViewCell
            cell.configuration = viewModel.similarMovies[indexPath.row].toMovieContentConfiguration()
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension MovieDetailsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = MovieDetailsViewModel.Section(rawValue: section) else {
            return 0
        }
        switch section {
        case .movieDetails:
            return viewModel.movieDetails == nil ? 0 : UITableView.automaticDimension
        case .similarMovies:
            return viewModel.similarMovies.isEmpty ? 0 : UITableView.automaticDimension
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = MovieDetailsViewModel.Section(rawValue: section) else {
            return nil
        }
        switch section {
        case .movieDetails:
            guard let movieDetails = viewModel.movieDetails else { return nil }
            let view = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: MovieDetailsHeaderView.identifier
            ) as! MovieDetailsHeaderView
            view.configuration = movieDetails.toMovieDetailsContentConfiguration()
            return view
        case .similarMovies:
            guard !viewModel.similarMovies.isEmpty else { return nil }
            let view = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: SimilarMoviesHeaderView.identifier
            ) as! SimilarMoviesHeaderView
            return view
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = MovieDetailsViewModel.Section(rawValue: indexPath.section) else {
            return
        }
        switch section {
        case .movieDetails:
            break
        case .similarMovies:
            let movie = viewModel.similarMovies[indexPath.item]
            let dependency = MovieDetailsViewModel.Dependency(id: movie.id)
            router.routeToMovieDetails(from: self, dependency: dependency)
        }
    }
}
