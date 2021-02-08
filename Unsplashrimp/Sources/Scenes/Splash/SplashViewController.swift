//
//  SplashViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SplashDisplayLogic: class {

}

final class SplashViewController: BaseViewController {

  var router: (SplashRoutingLogic & SplashDataPassing)?
  var interactor: SplashBusinessLogic?
  
}

// MARK: - Build
extension SplashViewController {
  override func build() {
    let viewController = self
    let interactor = SplashInteractor()
    let presenter = SplashPresenter()
    let router = SplashRouter()
    let worker = SplashWorker()
    
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
extension SplashViewController: SplashDisplayLogic {

}
