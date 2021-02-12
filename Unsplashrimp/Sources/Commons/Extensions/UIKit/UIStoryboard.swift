//
//  UIStoryboard.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/12.
//

import UIKit

extension UIStoryboard {
  convenience init(_ name: String, bundle: Bundle? = nil) {
    self.init(name: name, bundle: bundle)
  }
  var viewController: UIViewController {
    return instantiateInitialViewController() ?? UIViewController()
  }
}
