//
//  Extension+UIImageView.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

extension UIImageView {
    public func image(fromUrl url: URL) {
        let theTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: response)
                }
            }
        }
        theTask.resume()
    }
    
    public func image(fromString urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        image(fromUrl: url)
    }
}
