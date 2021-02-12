//
//  ExploreRouter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExploreRoutingLogic: class {
  func routeToDetail()
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
  func routeToDetail() {
    
    let detailViewController = UIStoryboard("Detail").viewController
    
    guard let destinationVC = detailViewController as? DetailViewController else { return }
    guard var destinationDS = destinationVC.router?.dataStore else { return }
    guard let source = dataStore else { return }
    
    destinationVC.delegate = viewController
    passDataToDetail(source: source, destination: &destinationDS)
    present(to: detailViewController, from: viewController)
  }
}

// MARK: - DataPassing
extension ExploreRouter {
  func passDataToDetail(
    source: ExploreDataStore,
    destination: inout DetailDataStore
  ) {
    destination.selectedPhotoIndex = source.selectedPhotoIndex
    destination.photos = source.photos
  }
}
