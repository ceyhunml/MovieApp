//
//  ActorViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 10.10.25.
//

import Foundation

class ActorViewModel {

    var data: Actor?
    var items = [ActorResult]()
    let manager = ActorManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getPopularActors() {
        let page = (data?.page ?? 0) + 1
        manager.getPopularActors(page: page) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.data = data
                self.items.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int) {
        guard let page = data?.page else { return }
        guard let totalPages = data?.totalPages else { return }
        
        if index == items.count - 2 && page < totalPages {
            getPopularActors()
        }
    }
}
