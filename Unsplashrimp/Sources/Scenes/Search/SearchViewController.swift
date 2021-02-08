//
//  SearchViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SearchDisplayLogic: class {

}

final class SearchViewController: BaseViewController {

  var router: (SearchRoutingLogic & SearchDataPassing)?
  var interactor: SearchBusinessLogic?
  
}

// MARK: - Configure
extension SearchViewController {
  override func build() {
    let viewController = self
    let interactor = SearchInteractor()
    let presenter = SearchPresenter()
    let router = SearchRouter()
    let worker = SearchWorker()
    
    interactor.presenter = presenter
    interactor.worker = worker
    presenter.view = viewController
    router.viewController = viewController
    router.dataStore = interactor
    viewController.interactor = interactor
    viewController.router = router
  }
}

// MARK: - Display
extension SearchViewController: SearchDisplayLogic {

}
