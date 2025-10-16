//
//  CastViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 10.10.25.
//

import Foundation

class CastViewModel {
    
    var items = [MovieResult]()
    let manager = ActorManager()
    
    var id: Int?
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getCastMovies() {
        manager.getActorMovies(actorId: id ?? 0, completion: { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items = data.cast ?? []
                self.success?()
            }
        })
    }
}
