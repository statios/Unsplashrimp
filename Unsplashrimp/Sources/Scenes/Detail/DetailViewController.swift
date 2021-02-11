//
//  DetailViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

protocol DetailDisplayLogic: class {

}

final class DetailViewController: BaseViewController {

  var router: (DetailRoutingLogic & DetailDataPassing)?
  var interactor: DetailBusinessLogic?
  
}

// MARK: - Configure
extension DetailViewController {
  override func build() {
    let viewController = self
    let interactor = DetailInteractor()
    let presenter = DetailPresenter()
    let router = DetailRouter()
    let worker = DetailWorker()
    
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
    navigationController?.navigationBar.transparentNavigationBar()
  }
}

// MARK: - Display
extension DetailViewController: DetailDisplayLogic {

}

// MARK: - Actions
extension DetailViewController {

}
