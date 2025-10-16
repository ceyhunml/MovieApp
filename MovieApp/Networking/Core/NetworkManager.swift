//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 05.10.25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func request<T: Codable>(url: String,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             completion: @escaping ((T?, String?) -> Void)) {
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   headers: NetworkingHelper.shared.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func request<T: Codable>(endpoint: Endpoint,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             completion: @escaping ((T?, String?) -> Void)) {
        let url = endpoint.path
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   headers: NetworkingHelper.shared.headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
