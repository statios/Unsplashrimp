//
//  MainTabBarController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/13.
//

import UIKit

class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    modalPresentationStyle = .fullScreen
    modalTransitionStyle = .crossDissolve
    tabBar.barTintColor = .black
    tabBar.isTranslucent = true
    tabBar.tintColor = .white
  }
}
