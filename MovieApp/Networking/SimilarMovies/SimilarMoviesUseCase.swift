//
//  SimilarMoviesUseCase.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 14.10.25.
//

import Foundation

protocol SimilarMoviesUseCase {
    func getSimilarMovies(movieId: Int, completion: @escaping (Movie?, String?) -> Void)
}
