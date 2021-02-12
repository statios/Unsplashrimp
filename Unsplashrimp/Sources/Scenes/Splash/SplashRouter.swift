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
    
    let exploreViewController = UIStoryboard("Explore").viewController
    let searchViewConroller = UIStoryboard("Search").viewController

    let tabBarController = [
      exploreViewController.embededIn(TransparentNavigationController.self),
      searchViewConroller.embededIn(TransparentNavigationController.self)
    ].embededIn(MainTabBarController.self)

    guard let source = dataStore else { return }
    guard let destinationVC = exploreViewController as? ExploreViewController else { return }
    guard var destinationDS = destinationVC.router?.dataStore else { return }
    
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
    destination.photosByTopics = source.photos
  }
}
