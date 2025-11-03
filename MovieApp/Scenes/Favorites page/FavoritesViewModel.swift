//
//  FavoritesViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 31.10.25.
//

import Foundation

class FavoritesViewModel {
    
    var favoritesIds = [Int]()
    var favoriteMovies = [MovieResult]()
    
    var success: (() -> Void)?
    var error: ((String)-> Void)?
    
    let managerForFavorites = FavoriteManager()
    let managerForMovies = MovieDetailsManager()
    
    func getFavorites() {
        managerForFavorites.getFavoriteIDs { data in
            self.favoritesIds = data
            self.loadMovies()
        }
    }
    
    func loadMovies() {
        let group = DispatchGroup()
        favoriteMovies.removeAll()
        
        for id in favoritesIds {
            group.enter()
            managerForMovies.getMovieDetails(movieId: id) { data, error in
                if let error {
                    self.error?(error)
                } else if let data {
                    self.favoriteMovies.append(data)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.success?()
        }
    }
}
