//
//  SplashRouter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SplashRoutingLogic: class {
  func routeToExplore()
}

protocol SplashDataPassing: class {
  var dataStore: SplashDataStore? { get set }
}

final class SplashRouter: BaseRouter, SplashDataPassing {
  
  weak var viewController: SplashViewController?
  var dataStore: SplashDataStore?
  
}

// MARK: - Route
extension SplashRouter: SplashRoutingLogic {
  func routeToExplore() {
    
    
    guard let exploreNavi = UIStoryboard(
      name: "Explore",
      bundle: nil
    ).instantiateInitialViewController()
    as? UINavigationController else { return }
    
    guard let explore = exploreNavi
            .viewControllers
            .first(where: {
              $0.isKind(of: ExploreViewController.self)
            }) as? ExploreViewController else { return }
    
    guard let search = UIStoryboard(
      name: "Search",
      bundle: nil
    ).instantiateInitialViewController() else {
      return
    }
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [exploreNavi, search]
    tabBarController.modalPresentationStyle = .overFullScreen
    tabBarController.modalTransitionStyle = .crossDissolve
    tabBarController.tabBar.barTintColor = .black
    tabBarController.tabBar.isTranslucent = false
    
    
    guard var destinationDS = explore.router?.dataStore else {
      
      return
    }
    
    guard let source = dataStore else {
      
      return
    }
    
    passDataToExplore(source: source, destination: &destinationDS)
    present(to: tabBarController, from: viewController)
  }
}

// MARK: - DataPassing
extension SplashRouter {
  func passDataToExplore(
    source: SplashDataStore,
    destination: inout ExploreDataStore
  ) {
    destination.topics = source.topics
    destination.photos = source.photos
  }
}
