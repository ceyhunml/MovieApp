//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 14.10.25.
//

import Foundation

class MovieDetailsViewModel {
    
    var movieId: Int?
    
    var selectedMovie: MovieResult?
    var trailers: [TrailerResult]?
    var similarMovies: [MovieResult]?
    
    let manager = NetworkManager()
    let managerForMovie = MovieDetailsManager()
    let managerForSimilar = SimilarMovieManager()
    
    var successForDetails: (() -> Void)?
    var successForSimilars: (() -> Void)?
    var successForTrailers: (() -> Void)?
    
    var error: ((String) -> Void)?
    
    func loadData() {
        getMovieDetails()
        getTrailers()
    }
    
    
    func getMovieDetails() {
        managerForMovie.getMovieDetails(movieId: movieId ?? 0) { [weak self] data, errorMessage in
            if let errorMessage {
                self?.error?(errorMessage)
            } else if let data {
                self?.selectedMovie = data
                self?.successForDetails?()
                self?.getSimilarMovies()
            }
        }
    }
    
    func getSimilarMovies() {
        managerForSimilar.getSimilarMovies(movieId: selectedMovie?.id ?? 0) { [weak self] data, errorMessage in
            if let errorMessage {
                self?.error?(errorMessage)
            } else if let data {
                self?.similarMovies = data.results ?? []
                self?.successForSimilars?()
            }
        }
    }
    
    func getTrailers() {
        managerForMovie.getMovieTrailers(movieId: movieId ?? 0) { [weak self] data, errorMessage in
            if let errorMessage {
                self?.error?(errorMessage)
            } else if let data {
                self?.trailers = data.results ?? []
                self?.successForTrailers?()
            }
        }
    }
}




