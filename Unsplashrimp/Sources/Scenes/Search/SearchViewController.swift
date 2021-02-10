//
//  SearchViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SearchDisplayLogic: class {
  func displaySearch(viewModel: SearchModels.Search.ViewModel)
}

final class SearchViewController: BaseViewController {

  var router: (SearchRoutingLogic & SearchDataPassing)?
  var interactor: SearchBusinessLogic?
  
  @IBOutlet weak var tableView: UITableView!
  
  lazy var searchController: UISearchController = {
    let s = UISearchController(searchResultsController: nil)
    s.searchBar.delegate = self
    s.obscuresBackgroundDuringPresentation = false
    s.searchBar.placeholder = "Search photos"
    s.searchBar.barStyle = .black
    return s
  }()
  
  fileprivate var photos: [Photo] = []
}

// MARK: - Configure
extension SearchViewController {
  override func build() {
    let viewController = self
    let interactor = SearchInteractor()
    let presenter = SearchPresenter()
    let router = SearchRouter()
    let worker = NetworkWorker.shared
    
    interactor.presenter = presenter
    interactor.networkWorker = worker
    presenter.view = viewController
    router.viewController = viewController
    router.dataStore = interactor
    viewController.interactor = interactor
    viewController.router = router
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.searchController = searchController
    definesPresentationContext = true
    title = "Unsplashrimp"
  }
}

// MARK: - Display
extension SearchViewController: SearchDisplayLogic {
  func displaySearch(viewModel: SearchModels.Search.ViewModel) {
    self.photos = viewModel.photos
    tableView.reloadData()
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let query = searchBar.text else { return }
    interactor?.fetchSearch(request: .init(query: query))
  }
}

extension SearchViewController:
  UITableViewDelegate,
  UITableViewDataSource,
  UITableViewDataSourcePrefetching {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return photos.count
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    let photo = photos[indexPath.row]
    return CGSize(width: photo.width, height: photo.height).toRatioSizedHeight()
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "SearchCell",
      for: indexPath
    ) as? SearchCell else { return SearchCell() }
    cell.configure(photos[indexPath.row])
    return cell
  }
  
  func tableView(
    _ tableView: UITableView,
    prefetchRowsAt indexPaths: [IndexPath]) {
    
  }
}
