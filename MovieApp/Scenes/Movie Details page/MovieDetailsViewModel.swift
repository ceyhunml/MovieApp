//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 14.10.25.
//

import Foundation

class MovieDetailsViewModel {
    
    var movieId: Int?
    var isFavorite = false
    
    var selectedMovie: MovieResult?
    var trailers: [TrailerResult]?
    var similarMovies: [MovieResult]?
    var movieCast: [CastResult]?
    
    let manager = NetworkManager()
    let managerForMovie = MovieDetailsManager()
    let managerForSimilar = SimilarMovieManager()
    let favoritesManager = FavoriteManager()
    
    var successForDetails: (() -> Void)?
    var successForSimilars: (() -> Void)?
    var successForTrailers: (() -> Void)?
    var successForCast: (() -> Void)?
    var successForFavorite: (() -> Void)?
    
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
                self?.isMovieFavorite(movie: data)
                self?.successForDetails?()
                self?.getSimilarMovies()
                self?.getMovieCast()
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
    
    func getMovieCast() {
        managerForMovie.getMovieCast(movieId: movieId ?? 0) { [weak self] data, errorMessage in
            if let errorMessage {
                self?.error?(errorMessage)
            } else if let data {
                self?.movieCast = data.cast ?? []
                guard let crew = data.crew else { return }
                for person in crew {
                    if person.job == "Director" {
                        self?.movieCast?.insert(person, at: 0)
                    }
                }
                self?.successForCast?()
            }
        }
    }
    
    func isMovieFavorite(movie: MovieResult) {
        favoritesManager.isFavorite(movieId: movie.id ?? 0) { trueOrFalse in
            if trueOrFalse == true {
                self.isFavorite = true
                self.successForFavorite?()
            }
        }
    }
}




