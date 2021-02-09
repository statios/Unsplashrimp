//
//  UIImageView.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/09.
//

import UIKit

extension UIImageView {
  func setImage(_ from: String) {
    guard let url = URL(string: from) else { return }
    guard let data = try? Data(contentsOf: url) else { return }
    guard let image = UIImage(data: data) else { return }
    self.image = image
  }
}
