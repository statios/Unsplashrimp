//
//  AppDelegate.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    setup(application)
    return true
  }
}

extension AppDelegate {
  func setup(_ application: UIApplication) {
    UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
    UINavigationBar.appearance().titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]
  }
}
