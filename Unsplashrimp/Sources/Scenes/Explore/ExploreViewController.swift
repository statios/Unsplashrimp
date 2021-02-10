//
//  ExploreViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExploreDisplayLogic: class {
  func displayTopics(viewModel: ExploreModels.Topics.ViewModel)
  func displayPhotos(viewModel: ExploreModels.Photos.ViewModel)
}

final class ExploreViewController: BaseViewController {

  var router: (ExploreRoutingLogic & ExploreDataPassing)?
  var interactor: ExploreBusinessLogic?
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var topics: [Topic] = []
  fileprivate var photos: [[Photo]] = []
  fileprivate var selectedIndex: Int = 0
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
    title = "Unsplashrimp"
    interactor?.fetchTopics(request: .init())
  }
}

// MARK: - Display
extension ExploreViewController: ExploreDisplayLogic {
  func displayTopics(viewModel: ExploreModels.Topics.ViewModel) {
    topics = viewModel.topics
    collectionView.reloadData()
    interactor?.fetchPhotos(request: .init())
  }
  
  func displayPhotos(viewModel: ExploreModels.Photos.ViewModel) {
    photos = viewModel.photos
    tableView.reloadData()
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
    guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TopicCell",
            for: indexPath
    ) as? TopicCell else { return UICollectionViewCell() }
    cell.configure(
      topics[indexPath.item],
      isSelected: selectedIndex == indexPath.item
    )
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    selectedIndex = indexPath.row
    collectionView.reloadData()
    tableView.reloadData()
  }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    guard !photos.isEmpty else {
      return 0
    }
    return photos[selectedIndex].count
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    let photo = photos[selectedIndex][indexPath.row]
    return CGSize(width: photo.width, height: photo.height).toRatioSizedHeight()
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PhotoCell",
            for: indexPath
    ) as? PhotoCell else { return PhotoCell() }
    cell.configure(photos[selectedIndex][indexPath.row])
    return cell
  }
}
