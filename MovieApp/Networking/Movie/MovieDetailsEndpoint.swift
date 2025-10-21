//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 17.10.25.
//

import Foundation

enum MovieDetailsEndpoint {
    
    case movie(movieId: Int)
    case trailer(movieId: Int)
    
    var path: String {
        switch self {
        case .movie(let movieId):
            return NetworkingHelper.shared.configureURL(endpoint: "/movie/\(movieId)")
        case .trailer(movieId: let movieId):
            return NetworkingHelper.shared.configureURL(endpoint: "/movie/\(movieId)/videos")
        }
    }
}
