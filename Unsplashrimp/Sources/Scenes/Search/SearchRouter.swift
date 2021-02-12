//
//  SearchRouter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SearchRoutingLogic: class {
  func routeToDetail()
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
  func routeToDetail() {
    
  }
}

// MARK: - DataPassing
extension SearchRouter {
  func passDataToDetail(
    source: SearchDataStore,
    destination: inout DetailDataStore
  ) {
    destination.selectedPhotoIndex = source.selectedPhotoIndex
    destination.photos = source.photos
  }
}
