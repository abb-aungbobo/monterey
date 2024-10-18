//
//  MovieContentView.swift
//  
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Extensions
import SnapKit
import UIKit

final class MovieContentView: UIView, UIContentView {
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let voteAverageLabel = UILabel()
    private let overviewLabel = UILabel()
    
    private var appliedConfiguration: MovieContentConfiguration!
    
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? MovieContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }
    
    init(configuration: MovieContentConfiguration) {
        super.init(frame: .zero)
        configureHierarchy()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        configureView()
        configurePosterImageView()
        configureTitleLabel()
        configureVoteAverageLabel()
        configureOverviewLabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func configurePosterImageView() {
        addSubview(posterImageView)
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.backgroundColor = .secondarySystemBackground
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerCurve = .continuous
        posterImageView.layer.cornerRadius = 8.0
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(96)
            make.height.equalTo(144)
        }
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func configureVoteAverageLabel() {
        addSubview(voteAverageLabel)
        voteAverageLabel.adjustsFontForContentSizeCategory = true
        voteAverageLabel.font = .preferredFont(forTextStyle: .subheadline)
        voteAverageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
        }
    }
    
    private func configureOverviewLabel() {
        addSubview(overviewLabel)
        overviewLabel.adjustsFontForContentSizeCategory = true
        overviewLabel.font = .preferredFont(forTextStyle: .subheadline)
        overviewLabel.textColor = .secondaryLabel
        overviewLabel.numberOfLines = 3
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(voteAverageLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func apply(configuration: MovieContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration
        
        posterImageView.setImage(with: configuration.poster)
        titleLabel.text = configuration.title
        voteAverageLabel.text = configuration.voteAverage
        overviewLabel.text = configuration.overview
    }
}
