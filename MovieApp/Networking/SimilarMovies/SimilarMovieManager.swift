//
//  SimilarMovieManager.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 14.10.25.
//

import Foundation

class SimilarMovieManager: SimilarMoviesUseCase {
    
    let manager = NetworkManager()
    
    func getSimilarMovies(movieId: Int, completion: @escaping (Movie?, String?) -> Void) {
        manager.request(url: SimilarMoviesEndpoint.similar(movieId: movieId).path,
                        model: Movie.self,
                        completion: completion)
    }
}
