//
//  UIImageView+Extension.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 05.10.25.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    
    func getImage(path: String, ImageSize: ImageSize = .original) {
        let url = URL(string: NetworkingHelper.shared.configureImageURL(path: path, ImageSize: ImageSize))
        kf.setImage(with: url)
    }
}
