//
//  SignUpViewModel.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 28.10.25.
//

import Foundation
import UIKit

class SignUpViewModel {
    
    let manager = AuthManager.shared
    
    func signUp(email: String, password: String) {
        manager.signUp(email: email, password: password) { error in
            if let error {
                print(error)
                self.manager.signIn(email: email, password: password) { userId in
                    if let userId {
                        UserDefaults.standard.set(userId, forKey: "userId")
                        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                            sceneDelegate.window?.rootViewController = sceneDelegate.createTabBar()
                        }
                    } else {
                        print("Login failed")
                    }
                }
            } else {
                print("User Registered")
                
            }
        }
    }
}
