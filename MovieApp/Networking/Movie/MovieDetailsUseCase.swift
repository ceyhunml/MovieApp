//
//  MovieDetailsProtocol.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 17.10.25.
//

import Foundation

protocol MovieDetailsUseCase {
    func getMovieDetails(movieId: Int, completion: @escaping (MovieResult?, String?) -> Void)
    func getMovieTrailers(movieId: Int, completion: @escaping (MovieVideoResponse?, String?) -> Void)
    
    func getMovieCast(movieId: Int, completion: @escaping (MovieCast?, String?) -> Void)
}
