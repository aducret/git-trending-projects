//
//  UIImageViewExtension.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/29/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadContentFromURL(imageURL: URL) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        
        URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
        }).resume()
    }
}
