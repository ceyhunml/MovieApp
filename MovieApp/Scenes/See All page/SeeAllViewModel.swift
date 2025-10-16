//
//  SeeAllViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 11.10.25.
//

import Foundation

class SeeAllViewModel {
    
    var item: Movie?
    
    var items = [MovieResult]()
    let manager = NetworkManager()
    
    var endpoint: String?
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getMoviesByType(endpoint: String?) {
        
        switch endpoint {
        case "Popular":
            let page = (item?.page ?? 0) + 1
            manager.request(endpoint: .popular(page: page),
                            model: Movie.self) { data, errorMesage in
                if let errorMesage {
                    self.error?(errorMesage)
                } else if let data {
                    self.item = data.self
                    self.items.append(contentsOf: data.results ?? [])
                    self.success?()
                }
            }
        case "Top Rated":
            let page = (item?.page ?? 0) + 1
            manager.request(endpoint: .topRated(page: page),
                            model: Movie.self) { data, errorMesage in
                if let errorMesage {
                    self.error?(errorMesage)
                } else if let data {
                    self.item = data.self
                    self.items.append(contentsOf: data.results ?? [])
                    self.success?()
                }
            }
        case "Now Playing":
            let page = (item?.page ?? 0) + 1
            manager.request(endpoint: .nowPlaying(page: page),
                            model: Movie.self) { data, errorMesage in
                if let errorMesage {
                    self.error?(errorMesage)
                } else if let data {
                    self.item = data.self
                    self.items.append(contentsOf: data.results ?? [])
                    self.success?()
                }
            }
        case "Upcoming":
            let page = (item?.page ?? 0) + 1
            manager.request(endpoint: .upcoming(page: page),
                            model: Movie.self) { data, errorMesage in
                if let errorMesage {
                    self.error?(errorMesage)
                } else if let data {
                    self.item = data.self
                    self.items.append(contentsOf: data.results ?? [])
                    self.success?()
                }
            }
        default:
            return
        }
    }
    
    func pagination(index: Int) {
        guard let page = item?.page else { return }
        guard let totalPages = item?.totalPages else { return }
        
        if index == items.count - 2 && page < totalPages {
            getMoviesByType(endpoint: self.endpoint)
        }
    }
}
