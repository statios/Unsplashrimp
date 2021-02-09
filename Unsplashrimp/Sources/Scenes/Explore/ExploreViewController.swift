//
//  ExploreViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExploreDisplayLogic: class {
  func displayTopics(viewModel: ExploreModels.Topics.ViewModel)
  func displaySelectedTopic(viewModel: ExploreModels.SelectTopic.ViewModel)
  func displayPhotos(viewModel: ExploreModels.Photos.ViewModel)
}

final class ExploreViewController: BaseViewController {

  var router: (ExploreRoutingLogic & ExploreDataPassing)?
  var interactor: ExploreBusinessLogic?
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var topics: [Topic] = []
  fileprivate var photos: [[Photo]] = []
  fileprivate var paginations: [Int] = []
  fileprivate var currentTopicIndex = 0
}

// MARK: - Configure
extension ExploreViewController {
  override func build() {
    let viewController = self
    let interactor = ExploreInteractor()
    let presenter = ExplorePresenter()
    let router = ExploreRouter()
    
    interactor.presenter = presenter
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
    paginations = viewModel.topics.map { _ in Int(0) }
    photos = viewModel.topics.map { _ in [Photo]() }
    collectionView.reloadData()
    interactor?.fetchSelectedTopic(
      request: .init(selected: .init(item: 0, section: 0))
    )
  }
  
  func displaySelectedTopic(viewModel: ExploreModels.SelectTopic.ViewModel) {
    DispatchQueue.main.async { [weak self] in
      if let previous = viewModel.previousSelected {
        let unSelectedCell = self?.collectionView.cellForItem(at: previous)
        unSelectedCell?.isSelected = false
      }
      let current = viewModel.currentSelected
      let selectedCell = self?.collectionView.cellForItem(at: current)
      selectedCell?.isSelected = true
    }
    
    let index = viewModel.currentSelected.item
    let page = paginations[index]
    currentTopicIndex = index
    
    // Initial fetching photos
    guard page == 0 else { return }
    let id = topics[index].id
    interactor?.fetchPhotos(
      request: .init(id: id, page: page, index: index)
    )
  }
  
  func displayPhotos(viewModel: ExploreModels.Photos.ViewModel) {
    paginations[viewModel.index] = viewModel.newPage
    photos[viewModel.index].append(contentsOf: viewModel.photos)
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
    cell.configure(topics[indexPath.item])
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    interactor?.fetchSelectedTopic(request: .init(selected: indexPath))
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
    return photos[currentTopicIndex].count
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    let photo = photos[currentTopicIndex][indexPath.row]
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
    cell.configure(photos[currentTopicIndex][indexPath.row])
    return cell
  }
}
