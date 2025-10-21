//
//  HomeCell.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 05.10.25.
//

import UIKit

protocol LabelTextImageViewCellProtocol {
    var labelText: String { get }
    var imageURL: String { get }
}

class LabelTextImageViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCell"
    
    private lazy var movieName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(movieName)
        addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: 240),
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            movieName.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 8),
            movieName.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieName.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(with movie: LabelTextImageViewCellProtocol) {
        movieName.text = movie.labelText
        movieImage.getImage(path: movie.imageURL, ImageSize: .w300)
    }
}
