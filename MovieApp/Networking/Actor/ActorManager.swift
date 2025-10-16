//
//  ActorManager.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 10.10.25.
//

import Foundation

class ActorManager {
    
    private let manager = NetworkManager()
    
    func getPopularActors(page: Int, completion: @escaping ((Actor?, String?) -> Void)) {
        manager.request(url: ActorEndpoint.popularActors(page: page).path,
                        model: Actor.self,
                        completion: completion)
    }
    
    func getActorMovies(actorId: Int, completion: @escaping (MovieCredit?, String?) -> Void) {
        manager.request(url: ActorEndpoint.actorMovies(actorId: actorId).path,
                        model: MovieCredit.self,
                        completion: completion)
    }
}
