//
//  String.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/10.
//

import Foundation
import UIKit

extension String {
  func cacheImage() {
    DispatchQueue.global(qos: .background).async {
      guard let url = URL(string: self) else { return }
      let urlString = url.absoluteString as NSString
      guard let data = try? Data(contentsOf: url) else { return }
      guard let image = UIImage(data: data) else { return }
      imageCache.setObject(image, forKey: urlString)
    }
  }
}
