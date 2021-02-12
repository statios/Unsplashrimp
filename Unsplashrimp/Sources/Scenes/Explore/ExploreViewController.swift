//
//  ExploreViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExploreDisplayLogic: DetailRoutableDisplayLogic {
  func displayTopics(viewModel: ExploreModels.Topics.ViewModel)
  func displayPhotos(viewModel: ExploreModels.Photos.ViewModel)
  func displayPagination(viewModel: ExploreModels.Pagination.ViewModel)
  func displaySelectTopic(viewModel: ExploreModels.SelectTopic.ViewModel)
  func displaySelectPhoto(viewModel: ExploreModels.SelectPhoto.ViewModel)
}

final class ExploreViewController: BaseViewController {
  
  var router: (ExploreRoutingLogic & ExploreDataPassing)?
  var interactor: ExploreBusinessLogic?
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var topics: [Topic] = []
  fileprivate var photos: [[Photo]] = []
  fileprivate var selectedTopicIndex: Int = 0
}

// MARK: - Configure
extension ExploreViewController {
  override func build() {
    let viewController = self
    let interactor = ExploreInteractor()
    let presenter = ExplorePresenter()
    let router = ExploreRouter()
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
    navigationController?.navigationBar.transparentNavigationBar()
    navigationItem.title = "Unsplashrimp"
    interactor?.fetchTopics(request: .init())
  }
}

// MARK: - Display
extension ExploreViewController: ExploreDisplayLogic {
  func displayTopics(viewModel: ExploreModels.Topics.ViewModel) {
    topics = viewModel.topics
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self else { return }
      self.collectionView.reloadData()
      self.collectionView.selectItem(
        at: .init(row: self.selectedTopicIndex, section: 0),
        animated: false,
        scrollPosition: .top
      )
    }
    interactor?.fetchPhotos(request: .init())
  }
  
  func displayPhotos(viewModel: ExploreModels.Photos.ViewModel) {
    photos = viewModel.photos
  }
  
  func displayPagination(viewModel: ExploreModels.Pagination.ViewModel) {
    photos[viewModel.index].append(contentsOf: viewModel.photos)
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  func displaySelectTopic(viewModel: ExploreModels.SelectTopic.ViewModel) {
    selectedTopicIndex = viewModel.index
    UIView.transition(
      with: tableView,
      duration: 0.35,
      options: .transitionCrossDissolve,
      animations: { [weak self] in
        self?.tableView.reloadData()
      }) { _ in }
  }
  
  func displaySelectPhoto(viewModel: ExploreModels.SelectPhoto.ViewModel) {
    router?.routeToDetail()
  }
  
  func displaySelectedPhoto(_ index: Int) {
    tableView.scrollToRow(
      at: .init(row: index, section: 0),
      at: .middle,
      animated: false
    )
  }
}

extension ExploreViewController:
  UICollectionViewDelegateFlowLayout,
  UICollectionViewDelegate,
  UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    .init(width: 128, height: 40)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return topics.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(TopicCell.self, for: indexPath)
    cell.configure(topics[indexPath.item])
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    interactor?.fetchSelectTopic(request: .init(index: indexPath.row))
  }
}

extension ExploreViewController:
  UITableViewDelegate,
  UITableViewDataSource,
  UITableViewDataSourcePrefetching {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    guard !photos.isEmpty else {
      return 0
    }
    return photos[selectedTopicIndex].count
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    let photo = photos[selectedTopicIndex][indexPath.row]
    return CGSize(width: photo.width, height: photo.height).toRatioSizedHeight()
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(PhotoCell.self, for: indexPath)
    cell.configure(photos[selectedTopicIndex][indexPath.row])
    return cell
  }
  
  func tableView(
    _ tableView: UITableView,
    prefetchRowsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      if photos[selectedTopicIndex].count - 1 == indexPath.row {
        interactor?.fetchPagination(
          request: .init(index: selectedTopicIndex)
        )
      }
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath) {
    interactor?.fetchSelectPhoto(request: .init(index: indexPath.row))
  }
}
