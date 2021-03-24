//
//  UIView+.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

extension UIView {
  @discardableResult
  func add(to: UIView) -> UIView {
    to.addSubview(self)
    return self
  }
}
