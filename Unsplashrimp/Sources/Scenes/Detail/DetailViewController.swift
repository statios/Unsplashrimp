//
//  DetailViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

protocol DetailDisplayLogic: class {
  func displayPhotos(request: DetailModels.Photos.ViewModel)
}

final class DetailViewController: BaseViewController {

  var router: (DetailRoutingLogic & DetailDataPassing)?
  var interactor: DetailBusinessLogic?
  
  @IBOutlet weak var dismissButton: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  fileprivate var photos: [Photo] = []
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
//    navigationController?.navigationBar.transparentNavigationBar()
    
    dismissButton.addTarget(
      self,
      action: #selector(tappedDismissButton),
      for: .touchUpInside
    )
    interactor?.fetchPhotos(request: .init())
  }
}

// MARK: - Display
extension DetailViewController: DetailDisplayLogic {
  func displayPhotos(request: DetailModels.Photos.ViewModel) {
    photos = request.photos
    collectionView.reloadData()
  }
}

// MARK: - Action
extension DetailViewController {
  @objc func tappedDismissButton() {
    dismiss(animated: true)
  }
}

extension DetailViewController:
  UICollectionViewDelegateFlowLayout,
  UICollectionViewDelegate,
  UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    Log.error(photos.count)
    return UIScreen.main.bounds.size
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    Log.error(photos.count)
    return photos.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DetailCell",
            for: indexPath
    ) as? DetailCell else { return UICollectionViewCell() }
    cell.configure(photos[indexPath.item])
    return cell
  }
}
