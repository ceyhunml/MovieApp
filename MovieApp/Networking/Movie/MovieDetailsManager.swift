//
//  MovieDetailsManager.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 17.10.25.
//

import Foundation

class MovieDetailsManager: MovieDetailsUseCase {
    
    let manager = NetworkManager()
    
    func getMovieDetails(movieId: Int, completion: @escaping (MovieResult?, String?) -> Void) {
        manager.request(url: MovieDetailsEndpoint.movie(movieId: movieId).path,
                        model: MovieResult.self,
                        completion: completion)
    }
    
    func getMovieTrailers(movieId: Int, completion: @escaping (MovieVideoResponse?, String?) -> Void) {
        manager.request(url: MovieDetailsEndpoint.trailer(movieId: movieId).path,
                        model: MovieVideoResponse.self,
                        completion: completion)
    }
}
