//
//  FavoriteUseCase.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 30.10.25.
//

import Foundation

protocol FavoriteUseCase {
    func saveToFavorite(movie: MovieResult)
    func removeFromFavorite(movie: MovieResult)
}
