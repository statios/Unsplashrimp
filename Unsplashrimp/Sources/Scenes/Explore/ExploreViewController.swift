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
}

final class ExploreViewController: BaseViewController {

  var router: (ExploreRoutingLogic & ExploreDataPassing)?
  var interactor: ExploreBusinessLogic?
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var topics: [Topic] = []
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
    return 8
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    let heights: [CGFloat] = [200, 300, 400, 500, 200, 300, 400 ,500 ]
    return heights[indexPath.row]
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PhotoCell",
            for: indexPath
    ) as? PhotoCell else { return PhotoCell() }
    let colors: [UIColor] = [
      .red, .brown, .systemTeal, .systemPink, .red, .brown, .systemTeal, .systemPink
    ]
    cell.backgroundColor = colors[indexPath.row]
    return cell
  }
}

extension ExploreViewController {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
  }
}
