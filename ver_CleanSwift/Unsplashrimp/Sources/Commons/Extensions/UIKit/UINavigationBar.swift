//
//  UINavigationBar.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/09.
//

import Foundation
import UIKit

extension UINavigationBar {
  func transparentNavigationBar() {
    setBackgroundImage(UIImage(), for: .default)
    shadowImage = UIImage()
    isTranslucent = true
  }
}
