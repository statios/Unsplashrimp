//
//  ExploreViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExploreDisplayLogic: class {

}

final class ExploreViewController: BaseViewController {

  var router: (ExploreRoutingLogic & ExploreDataPassing)?
  var interactor: ExploreBusinessLogic?
  
}

// MARK: - Configure
extension ExploreViewController {
  override func build() {
    let viewController = self
    let interactor = ExploreInteractor()
    let presenter = ExplorePresenter()
    let router = ExploreRouter()
    let worker = ExploreWorker()
    
    interactor.presenter = presenter
    interactor.worker = worker
    presenter.view = viewController
    router.viewController = viewController
    router.dataStore = interactor
    viewController.interactor = interactor
    viewController.router = router
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let network = NetworkingWorker()
      
    network
      .request(UnsplashAPI.topics, type: [Topic].self) {
        switch $0 {
        case let .success(data):
          Log.error(data)
        case let .failure(error):
          Log.error(error)
        }
      }
  }
}

// MARK: - Display
extension ExploreViewController: ExploreDisplayLogic {

}
