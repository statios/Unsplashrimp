//
//  ExploreRouter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExploreRoutingLogic: class {
  
}

protocol ExploreDataPassing: class {
  var dataStore: ExploreDataStore? { get set }
}

final class ExploreRouter: BaseRouter, ExploreDataPassing {

  weak var viewController: ExploreViewController?
  var dataStore: ExploreDataStore?

}

// MARK: - Route
extension ExploreRouter: ExploreRoutingLogic {

}
