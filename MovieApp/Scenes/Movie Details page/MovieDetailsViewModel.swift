//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 14.10.25.
//

import Foundation

class MovieDetailsViewModel {
    
    var selectedMovie: MovieResult?
    
    var similarMovies = [MovieResult]()
    
    let manager = NetworkManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getSimilarMovies() {
        manager.request(url: SimilarMoviesEndpoint.similar(movieId: selectedMovie?.id ?? 0).path,
                        model: Movie.self) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.similarMovies = data.results ?? []
                self.success?()
            }
        }
    }
}
