//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 05.10.25.
//

import Foundation

struct HomeModel {
    let title: String
    let movies: [MovieResult]
}

final class HomeViewModel {
    private let manager = NetworkManager()
    
    var items = [HomeModel]()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getMovieData() {
        getPopularMovies()
        getUpcomingMovies()
        getTopRatedMovies()
        getNowPlayingMovies()
    }
    
    func getPopularMovies() {
        manager.request(endpoint: .popular(page: 1),
                        model: Movie.self) { data, errorMesage in
            if let errorMesage {
                self.error?(errorMesage)
            } else if let data {
                self.items.append(.init(title: "Popular", movies: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getNowPlayingMovies() {
        manager.request(endpoint: .nowPlaying(page: 1),
                        model: Movie.self) { data, errorMesage in
            if let errorMesage {
                self.error?(errorMesage)
            } else if let data {
                self.items.append(.init(title: "Now Playing", movies: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getTopRatedMovies() {
        manager.request(endpoint: .topRated(page: 1),
                        model: Movie.self) { data, errorMesage in
            if let errorMesage {
                self.error?(errorMesage)
            } else if let data {
                self.items.append(.init(title: "Top Rated", movies: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func getUpcomingMovies() {
        manager.request(endpoint: .upcoming(page: 1),
                        model: Movie.self) { data, errorMesage in
            if let errorMesage {
                self.error?(errorMesage)
            } else if let data {
                self.items.append(.init(title: "Upcoming", movies: data.results ?? []))
                self.success?()
            }
        }
    }
}
