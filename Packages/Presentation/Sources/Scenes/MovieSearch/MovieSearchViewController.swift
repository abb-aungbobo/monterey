//
//  MovieSearchViewController.swift
//  
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Core
import SnapKit
import UIKit

final public class MovieSearchViewController: BaseViewController {
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView!
    
    private let viewModel: MovieSearchViewModel
    private let router: AppRouter
    
    public init(viewModel: MovieSearchViewModel, router: AppRouter) {
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
    }
    
    private func configureHierarchy() {
        configureView()
        configureNavigationItem()
        configureSearchBar()
        configureCollectionView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationItem() {
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.titleView = searchBar
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        searchBar.placeholder = "Search"
        searchBar.autocapitalizationType = .none
        searchBar.returnKeyType = .default
        searchBar.becomeFirstResponder()
    }
    
    private func configureCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier
        )
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: MovieSearchViewModel.State) {
        switch state {
        case .idle:
            clearContentUnavailableConfiguration()
        case let .failed(error):
            clearContentUnavailableConfiguration()
            showErrorAlert(error: error)
        case .succeeded:
            if let searchText = searchBar.text, !searchText.isEmpty && viewModel.movies.isEmpty {
                showEmptySearchResult()
            } else {
                clearContentUnavailableConfiguration()
            }
            collectionView.reloadData()
        }
    }
    
    private func showEmptySearchResult() {
        contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

// MARK: - UISearchBarDelegate
extension MovieSearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.query.send(searchText)
    }
}

// MARK: - UISearchTextFieldDelegate
extension MovieSearchViewController: UISearchTextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension MovieSearchViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as! MovieCollectionViewCell
        let configuration = viewModel.movies[indexPath.item].toMovieContentConfiguration()
        cell.configuration = configuration
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MovieSearchViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.item]
        let dependency = MovieDetailsViewModel.Dependency(id: movie.id)
        router.routeToMovieDetails(from: self, dependency: dependency)
    }
}
