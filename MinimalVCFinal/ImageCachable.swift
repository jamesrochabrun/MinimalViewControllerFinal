//
//  ImageCachable.swift
//  Flick
//
//  Created by James Rochabrun on 3/31/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCachable {}
let imageCache = NSCache<NSString, UIImage>()


extension UIImageView: ImageCachable {}

extension ImageCachable where Self: UIImageView {
    
    typealias SuccessCompletion = (Bool) -> ()
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
            }
            return
        }
        self.image = placeHolder
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                    }
                } else {
                    self.image = placeHolder
                }
            }).resume()
        } else {
            self.image = placeHolder
        }
    }
}















