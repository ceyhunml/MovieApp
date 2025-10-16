//
//  ActorUseCase.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 10.10.25.
//

import Foundation

protocol ActorUseCase {
    func getPopularActors(completion: @escaping ((Actor?, String?) -> Void))
    func getActorMovies(actorId: Int, completion: @escaping ((MovieCredit?, String?) -> Void))
}
