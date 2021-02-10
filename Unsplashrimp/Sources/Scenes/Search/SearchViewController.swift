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
  
  let searchController = UISearchController(searchResultsController: nil)
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search photos"
    searchController.searchBar.barStyle = .black
    navigationItem.searchController = searchController
    definesPresentationContext = true
    title = "Unsplashrimp"
  }
}

// MARK: - Display
extension SearchViewController: SearchDisplayLogic {

}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }
}
