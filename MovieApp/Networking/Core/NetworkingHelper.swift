//
//  NetworkingHelper.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 05.10.25.
//

import Foundation
import Alamofire

enum Endpoint {
    case popular(page: Int)
    case topRated(page: Int)
    case nowPlaying(page: Int)
    case upcoming(page: Int)
    
    var path: String {
        switch self {
        case .popular(let page):
            return NetworkingHelper.shared.configureURL(endpoint: "/movie/popular?page=\(page)")
        case .topRated(let page):
            return NetworkingHelper.shared.configureURL(endpoint: "/movie/top_rated?page=\(page)")
        case .nowPlaying(let page):
            return NetworkingHelper.shared.configureURL(endpoint: "/movie/now_playing?page=\(page)")
        case .upcoming(let page):
            return NetworkingHelper.shared.configureURL(endpoint: "/movie/upcoming?page=\(page)")
        }
    }
}

enum ImageSize: String {
    case original = "original"
    case w300 = "w300"
}

final class NetworkingHelper {
    
    private let version = "3"
    
    private let baseURL = "https://api.themoviedb.org/"
    
    private let imageBaseURL = "https://image.tmdb.org/t/p/"
    
    private let youtubeURL = "https://www.youtube.com/embed/"
    
    let headers: HTTPHeaders = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsIm5iZiI6MTY0ODYyMDAzNC4xNTgwMDAyLCJzdWIiOiI2MjQzZjIwMmM1MGFkMjAwNWNkZTk1ZjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xs9Bib0qWPDMeB9YXyPkYa4CzmQ5W4-N6rgdaLRPlZc"]
    
    static let shared = NetworkingHelper()
    
    private init() {}
    
    func configureURL(endpoint: String) -> String {
        baseURL + version + "/" + endpoint
    }
    
    func getYoutubeURL(key: String) -> String {
        youtubeURL + key
    }
        
    func configureImageURL(path: String, ImageSize: ImageSize) -> String {
        imageBaseURL + ImageSize.rawValue + path
    }
}
