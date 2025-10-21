//
//  SearchEndPoint.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 16.10.25.
//

import Foundation

enum SearchEndPoint {
    
    case search(query: String, page: Int)
    
    var path: String {
        switch self {
        case .search(let query, let page):
            return NetworkingHelper.shared.configureURL(endpoint: "/search/movie?query=\(query)&page=\(page)")
        }
    }
}
