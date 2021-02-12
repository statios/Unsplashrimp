//
//  UIViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/12.
//

import UIKit

extension UIViewController {
  func embededIn<T: UINavigationController>(_ type: T.Type) -> T {
    return T(rootViewController: self)
  }
}

extension Array where Element == UIViewController {
  func embededIn<T: UITabBarController>(_ type: T.Type) -> T {
    let tabBarController = T()
    tabBarController.viewControllers = self
    return tabBarController
  }
}
