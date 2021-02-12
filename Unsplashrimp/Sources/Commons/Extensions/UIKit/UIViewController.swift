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
  
  func setTabBarHidden(hidden: Bool, animated: Bool) {
    guard let tabBar = self.tabBarController?.tabBar else { return; }
    let frame = tabBar.frame
    let offset = hidden
      ? Device.height + frame.height
      : Device.height - frame.height
    
    UIView.animate(withDuration: 0.5) {
      tabBar.frame.origin.y = offset
    }
  }
}

extension Array where Element == UIViewController {
  func embededIn<T: UITabBarController>(_ type: T.Type) -> T {
    let tabBarController = T()
    tabBarController.viewControllers = self
    return tabBarController
  }
}
