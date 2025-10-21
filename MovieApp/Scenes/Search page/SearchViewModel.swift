//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 16.10.25.
//

import Foundation

class SearchViewModel {
    
    var item: Movie?
    
    var query: String?
    
    var items = [MovieResult]()
    
    let popularManager = NetworkManager()
    
    let searchManager = SearchManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getPopularMovies() {
        popularManager.request(endpoint: .popular(page: 1),
                        model: Movie.self) { data, errorMesage in
            if let errorMesage {
                self.error?(errorMesage)
            } else if let data {
                self.items = data.results ?? []
                self.success?()
            }
        }
    }
    
    func searchMovie() {
        let page = (item?.page ?? 0) + 1
        searchManager.searchMovie(query: query ?? "", page: page) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.item = data
                self.items.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int) {
        guard let page = item?.page else { return }
        guard let totalPages = item?.totalPages else { return }
        
        if index == items.count - 2 && page < totalPages {
            searchMovie()
        }
    }
}
