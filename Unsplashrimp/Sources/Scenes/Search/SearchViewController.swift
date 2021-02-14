//
//  SearchViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SearchDisplayLogic: DetailRoutableDisplayLogic {
  func displaySearch(viewModel: SearchModels.Search.ViewModel)
  func displayPagination(viewModel: SearchModels.Pagination.ViewModel)
  func displaySelectPhoto(viewModel: SearchModels.SelectPhoto.ViewModel)
  func displayErrorMessage(viewModel: SearchModels.ErrorMessage.ViewModel)
}

final class SearchViewController: BaseViewController {
  var router: (SearchRoutingLogic & SearchDataPassing)?
  var interactor: SearchBusinessLogic?
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var emptyLabel: UILabel!
  
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
    navigationItem.title = "Unsplashrimp"
  }
}

// MARK: - Display
extension SearchViewController: SearchDisplayLogic {
  func displaySearch(viewModel: SearchModels.Search.ViewModel) {
    tableView.isHidden = viewModel.photos.isEmpty
    emptyLabel.isHidden = !viewModel.photos.isEmpty
    photos = viewModel.photos
    tableView.reloadData()
  }
  
  func displayPagination(viewModel: SearchModels.Pagination.ViewModel) {
    photos.append(contentsOf: viewModel.photos)
    tableView.reloadData()
  }
  
  func displaySelectPhoto(viewModel: SearchModels.SelectPhoto.ViewModel) {
    router?.routeToDetail()
  }
  
  func displaySelectedPhoto(_ index: Int) {
    tableView.scrollToRow(
      at: .init(row: index, section: 0),
      at: .middle,
      animated: false
    )
  }
  
  func displayErrorMessage(viewModel: SearchModels.ErrorMessage.ViewModel) {
    showAlert(message: viewModel.message)
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let query = searchBar.text else { return }
    interactor?.fetchSearch(request: .init(query: query))
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    photos.removeAll()
    tableView.reloadData()
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
    let cell = tableView.dequeueReusableCell(SearchCell.self, for: indexPath)
    cell.configure(photos[indexPath.row])
    return cell
  }
  
  func tableView(
    _ tableView: UITableView,
    prefetchRowsAt indexPaths: [IndexPath]
  ) {
    for indexPath in indexPaths {
      if photos.count - 1 == indexPath.row {
        interactor?.fetchPagination(request: .init())
      }
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    interactor?.fetchSelectPhoto(
      request: .init(index: indexPath.row)
    )
  }
}

extension SearchViewController {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let recognizer = scrollView.panGestureRecognizer
    let condition = recognizer.translation(in: scrollView).y < 0
    setTabBarHidden(hidden: condition, animated: true)
  }
}
