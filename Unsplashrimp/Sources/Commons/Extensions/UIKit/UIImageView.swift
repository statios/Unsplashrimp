//
//  UIImageView.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/09.
//
// https://stackoverflow.com/questions/42856065/

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  func loadImageUsingCache(with URLString: String, placeHolder: UIImage?) {
    
    if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
      self.image = cachedImage
      return
    }
    
    guard let url = URL(string: URLString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if error != nil {
        Log.error("Failed image download")
        self.image = placeHolder
        return
      }
      
      DispatchQueue.main.async { [weak self] in
        guard let `data` = data,
              let downloadedImage = UIImage(data: data) else { return }
        imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
        self?.image = downloadedImage
      }
      
    }.resume()
  }
}
