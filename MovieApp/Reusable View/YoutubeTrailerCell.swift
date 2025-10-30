//
//  YoutubeTrailerCell.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 17.10.25.
//

import Foundation
import YouTubeiOSPlayerHelper

final class YouTubeTrailerCell: UICollectionViewCell {
    static let identifier = "YouTubeTrailerCell"
    
    private let youtubeView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(youtubeView)
        NSLayoutConstraint.activate([
            youtubeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            youtubeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            youtubeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            youtubeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with key: String) {
        youtubeView.load(withVideoId: key)
    }
}
