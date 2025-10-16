//
//  SimilarMoviesEndpoint.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 14.10.25.
//

import Foundation

enum SimilarMoviesEndpoint {
    case similar(movieId: Int)
    
    var path: String {
        switch self {
        case .similar(let movieId):
            return NetworkingHelper.shared.configureURL(endpoint:  "movie/\(movieId)/similar")
        }
    }
}
