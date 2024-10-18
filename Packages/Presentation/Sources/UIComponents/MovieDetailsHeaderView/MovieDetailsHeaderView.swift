//
//  MovieDetailsHeaderView.swift
//
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Extensions
import SnapKit
import UIKit

final class MovieDetailsHeaderView: UITableViewHeaderFooterView {
    private let posterImageView = UIImageView()
    private let voteAverageLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let runtimeLabel = UILabel()
    private let titleLabel = UILabel()
    private let genresLabel = UILabel()
    private let overviewLabel = UILabel()
    
    var configuration: MovieDetailsContentConfiguration! {
        didSet {
            apply(configuration: configuration)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        configureView()
        configurePosterImageView()
        configureVoteAverageLabel()
        configureReleaseDateLabel()
        configureRuntimeLabel()
        configureTitleLabel()
        configureGenresLabel()
        configureOverviewLabel()
    }
    
    private func configureView() {
        contentView.backgroundColor = .systemBackground
    }
    
    private func configurePosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.backgroundColor = .secondarySystemBackground
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerCurve = .continuous
        posterImageView.layer.cornerRadius = 8.0
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(96)
            make.height.equalTo(144)
        }
    }
    
    private func configureVoteAverageLabel() {
        contentView.addSubview(voteAverageLabel)
        voteAverageLabel.adjustsFontForContentSizeCategory = true
        voteAverageLabel.font = .preferredFont(forTextStyle: .body)
        voteAverageLabel.textColor = .secondaryLabel
        voteAverageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
        }
    }
    
    private func configureReleaseDateLabel() {
        contentView.addSubview(releaseDateLabel)
        releaseDateLabel.adjustsFontForContentSizeCategory = true
        releaseDateLabel.font = .preferredFont(forTextStyle: .body)
        releaseDateLabel.textColor = .secondaryLabel
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(voteAverageLabel.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
        }
    }
    
    private func configureRuntimeLabel() {
        contentView.addSubview(runtimeLabel)
        runtimeLabel.adjustsFontForContentSizeCategory = true
        runtimeLabel.font = .preferredFont(forTextStyle: .body)
        runtimeLabel.textColor = .secondaryLabel
        runtimeLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
        }
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .preferredFont(forTextStyle: .title1, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func configureGenresLabel() {
        contentView.addSubview(genresLabel)
        genresLabel.adjustsFontForContentSizeCategory = true
        genresLabel.font = .preferredFont(forTextStyle: .body)
        genresLabel.numberOfLines = 0
        genresLabel.textColor = .secondaryLabel
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func configureOverviewLabel() {
        contentView.addSubview(overviewLabel)
        overviewLabel.adjustsFontForContentSizeCategory = true
        overviewLabel.font = .preferredFont(forTextStyle: .subheadline)
        overviewLabel.numberOfLines = 0
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func apply(configuration: MovieDetailsContentConfiguration) {
        posterImageView.setImage(with: configuration.posterURL)
        voteAverageLabel.text = configuration.voteAverage
        releaseDateLabel.text = configuration.releaseDate
        runtimeLabel.text = configuration.runtime
        titleLabel.text = configuration.title
        genresLabel.text = configuration.genres
        overviewLabel.text = configuration.overview
        
        genresLabel.isHidden = configuration.hideGenres
    }
}
