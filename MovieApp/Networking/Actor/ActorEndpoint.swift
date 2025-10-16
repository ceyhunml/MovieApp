//
//  ActorEndpoint.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 10.10.25.
//

import Foundation

enum ActorEndpoint {
    
    case popularActors(page: Int)
    case actorMovies(actorId: Int)
    
    var path: String {
        switch self {
        case .popularActors(let page):
            return NetworkingHelper.shared.configureURL(endpoint: "person/popular?page=\(page)")
        case .actorMovies(let actorId):
            return NetworkingHelper.shared.configureURL(endpoint: "person/\(actorId)/movie_credits")
        }
    }
}
