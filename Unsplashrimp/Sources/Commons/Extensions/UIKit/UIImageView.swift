//
//  UIImageView.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/09.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  func setImage(_ from: String) {
    guard let url = URL(string: from) else { return }
    let urlString = url.absoluteString as NSString
    
    guard let cachedImage = imageCache.object(forKey: urlString) else {
      
      guard let data = try? Data(contentsOf: url) else { return }
      guard let image = UIImage(data: data) else { return }
      
      DispatchQueue.global(qos: .background).async {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
      }
      
      DispatchQueue.main.async {
        self.image = image
      }
      
      return
    }
    
    self.image = cachedImage
  }
}
