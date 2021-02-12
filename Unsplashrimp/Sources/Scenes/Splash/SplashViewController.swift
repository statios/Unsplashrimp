//
//  SplashViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SplashDisplayLogic: class {
  func displayPrefetch(viewModel: SplashModels.Prefetch.ViewModel)
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
    let worker = NetworkWorker.shared
    
    interactor.presenter = presenter
    interactor.networkWorker = worker
    presenter.view = viewController
    router.viewController = viewController
    router.dataStore = interactor
    viewController.interactor = interactor
    viewController.router = router
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    interactor?.fetchPrefetch(request: .init())
  }
}

// MARK: - Display
extension SplashViewController: SplashDisplayLogic {
  func displayPrefetch(viewModel: SplashModels.Prefetch.ViewModel) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
      self?.router?.routeToExplore()
    }
  }
}
