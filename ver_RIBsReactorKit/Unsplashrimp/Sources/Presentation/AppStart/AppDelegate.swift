//
//  AppDelegate.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit
import Then
import RIBs

@main
class AppDelegate:
  UIResponder,
  UIApplicationDelegate
{
  
  var window: UIWindow?
  
  private var launchRouter: LaunchRouting?
  
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    launchRouter = SplashBuilder(dependency: AppComponent()).build()
    launchRouter?.launch(from: window!)
    
    return true
  }
  
}
