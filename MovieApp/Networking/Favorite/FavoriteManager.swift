//
//  FavoriteManager.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 30.10.25.
//

import Foundation
import FirebaseFirestore

class FavoriteManager: FavoriteUseCase {
    
    let db = Firestore.firestore()
    
    func saveToFavorite(movie: MovieResult) {
        let data: [String : Any] = [
            "movieId": movie.id ?? 0,
            "movieName": movie.labelText,
            "movieImage": movie.imageURL
        ]
        guard let userId = UserDefaults.standard.string(forKey: "userId") else { return }
        db.collection(userId).document("\(movie.id ?? 0)").setData(data) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("Added to favorites!")
            }
        }
    }
    
    func removeFromFavorite(movie: MovieResult) {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else { return }
        db.collection(userId).document("\(movie.id ?? 0)").delete(completion: { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("Deleted from favorites!")
            }
        })
    }
    
    func isFavorite(movieId: Int, completion: @escaping (Bool) -> Void) {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            completion(false)
            return
        }
        
        db.collection(userId).document("\(movieId)").getDocument { snapshot, error in
            if let error = error {
                print("Check failed:", error.localizedDescription)
                completion(false)
            } else {
                completion(snapshot?.exists == true)
            }
        }
    }
}
