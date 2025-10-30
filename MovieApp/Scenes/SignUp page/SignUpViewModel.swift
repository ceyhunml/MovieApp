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
                self.manager.signIn(email: email, password: password) { error in
                    if let error {
                        print(error)
                        
                    } else {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            if let delegate = windowScene.delegate as? SceneDelegate {
                                delegate.window?.rootViewController = delegate.createTabBar()
                                delegate.window?.makeKeyAndVisible()
                            }
                        }
                    }
                }
            } else {
                print("User Registered")
            }
        }
    }
}
