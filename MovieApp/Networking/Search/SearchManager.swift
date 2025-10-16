//
//  SearchManager.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 16.10.25.
//

import Foundation

class SearchManager {
    
    let manager = NetworkManager()
    
    func searchMovie(query: String, completion: @escaping (Movie?, String?) -> Void) {
        manager.request(url: SearchEndPoint.search(query: query).path,
                        model: Movie.self,
                        completion: completion)
    }
}
