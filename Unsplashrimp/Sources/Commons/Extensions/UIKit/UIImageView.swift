//
//  UIImageView.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/09.
//
// https://stackoverflow.com/questions/42856065/uitableview-is-not-smoothly-when-using-downloading-images

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?) {
    
    if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
      self.image = cachedImage
      return
    }
    
    if let url = URL(string: URLString) {
      URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        
        if error != nil {
          print("ERROR LOADING IMAGES FROM URL: \(error)")
          self.image = placeHolder
          return
        }
        
        DispatchQueue.main.async {
          if let data = data {
            if let downloadedImage = UIImage(data: data) {
              imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
              self.image = downloadedImage
            }
          }
        }
        
      }).resume()
    }
  }
}
