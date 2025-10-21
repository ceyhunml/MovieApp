//
//  MovieDetailCoordinator.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 16.10.25.
//

import UIKit

class MovieDetailCoordinator {
    
    var movieId: Int
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,
         movieId: Int) {
        self.navigationController = navigationController
        self.movieId = movieId
    }
    
    func start() {
        let controller = MovieDetailsViewController()
        controller.viewModel.movieId = movieId
        navigationController.show(controller, sender: nil)
    }
}
