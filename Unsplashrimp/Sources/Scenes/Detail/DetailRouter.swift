//
//  DetailRouter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

protocol DetailRoutingLogic: class {

}

protocol DetailDataPassing: class {
  var dataStore: DetailDataStore? { get set }
}

final class DetailRouter: BaseRouter, DetailDataPassing {

  weak var viewController: DetailViewController?
  var dataStore: DetailDataStore?

}

// MARK: - Route
extension DetailRouter: DetailRoutingLogic {

}
