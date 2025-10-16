//
//  MovieDetailsViewCell.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 11.10.25.
//

import UIKit

protocol MovieDetailsViewCellProtocol {
    var labelText: String { get }
    var miniPosterURL: String { get }
    var bigPosterURL: String { get }
    var movieOverview: String { get }
    var movieReleaseDate: String { get }
    var movieVoteAverage: Double { get }
}

class MovieDetailsViewCell: UICollectionViewCell {
    
    static let identifier = "MovieDetailsCell"
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieMiniPoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let movieBigPoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.opacity = 0.85
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let movieOverview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieRating: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieReleaseDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(movieName)
        contentView.addSubview(movieMiniPoster)
        contentView.addSubview(movieBigPoster)
        contentView.addSubview(movieRating)
        contentView.addSubview(movieOverview)
        contentView.addSubview(movieReleaseDate)
        contentView.bringSubviewToFront(movieMiniPoster)
        
        NSLayoutConstraint.activate([
            movieBigPoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieBigPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieBigPoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieBigPoster.heightAnchor.constraint(equalTo: movieBigPoster.widthAnchor, multiplier: 0.6),
            
            movieMiniPoster.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieMiniPoster.topAnchor.constraint(equalTo: movieBigPoster.bottomAnchor, constant: -100),
            movieMiniPoster.widthAnchor.constraint(equalToConstant: 180),
            movieMiniPoster.heightAnchor.constraint(equalToConstant: 250),
            
            movieName.topAnchor.constraint(equalTo: movieMiniPoster.bottomAnchor, constant: 12),
            movieName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            movieReleaseDate.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 4),
            movieReleaseDate.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            movieRating.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor, constant: 4),
            movieRating.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            movieOverview.topAnchor.constraint(equalTo: movieRating.bottomAnchor, constant: 16),
            movieOverview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieOverview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            movieOverview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with movie: MovieDetailsViewCellProtocol) {
        movieName.text = movie.labelText
        movieMiniPoster.getImage(path: movie.miniPosterURL)
        movieBigPoster.getImage(path: movie.bigPosterURL)
        movieRating.text = "★ \(String(movie.movieVoteAverage))"
        movieOverview.text = movie.movieOverview
        movieReleaseDate.text = movie.movieReleaseDate
        print(movieRating)
        print(movieOverview)
        print(movieReleaseDate)
    }
}
