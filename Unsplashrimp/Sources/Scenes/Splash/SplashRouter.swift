//
//  SplashRouter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SplashRoutingLogic: class {

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

}
