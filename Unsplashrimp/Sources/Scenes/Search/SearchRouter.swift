//
//  SearchRouter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SearchRoutingLogic: class {

}

protocol SearchDataPassing: class {
  var dataStore: SearchDataStore? { get set }
}

final class SearchRouter: BaseRouter, SearchDataPassing {

  weak var viewController: SearchViewController?
  var dataStore: SearchDataStore?

}

// MARK: - Route
extension SearchRouter: SearchRoutingLogic {

}
