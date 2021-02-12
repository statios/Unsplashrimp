//
//  DetailViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

protocol DetailDisplayLogic: class {
  func displayPhotos(viewModel: DetailModels.Photos.ViewModel)
  func displayPaging(viewModel: DetailModels.Paging.ViewModel)
  func displayDismiss(viewModel: DetailModels.Dismiss.ViewModel)
}

final class DetailViewController: BaseViewController {

  var router: (DetailRoutingLogic & DetailDataPassing)?
  var interactor: DetailBusinessLogic?
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var dismissButton: UIBarButtonItem!
  @IBOutlet weak var customNavigationItem: UINavigationItem!
  
  weak var delegate: DetailRoutableDisplayLogic?
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
    navigationBar.transparentNavigationBar()
    dismissButton.target = self
    dismissButton.action = #selector(tappedDismissButton)
    interactor?.fetchPhotos(request: .init())
  }
}

// MARK: - Display
extension DetailViewController: DetailDisplayLogic {
  func displayPhotos(viewModel: DetailModels.Photos.ViewModel) {
    photos = viewModel.photos
    let index = viewModel.selectedPhotoIndex
    let name = photos[index].user.name
    DispatchQueue.main.async { [weak self] in
      self?.customNavigationItem.title = name
      self?.collectionView.reloadData()
      self?.collectionView.scrollToItem(
        at: .init(item: index, section: 0),
        at: .centeredHorizontally,
        animated: false
      )
    }
  }
  
  func displayPaging(viewModel: DetailModels.Paging.ViewModel) {
    customNavigationItem.title = viewModel.username
  }
  
  func displayDismiss(viewModel: DetailModels.Dismiss.ViewModel) {
    delegate?.displaySelectedPhoto(viewModel.selectedPhotoIndex)
    dismiss(animated: true)
  }
}

// MARK: - Action
extension DetailViewController {
  @objc func tappedDismissButton() {
    interactor?.fetchDismiss(request: .init())
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
    return Device.size
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return photos.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(DetailCell.self, for: indexPath)
    cell.configure(photos[indexPath.item])
    cell.delegate = self
    return cell
  }
}

extension DetailViewController: DetailCellDelegate {
  func didSelectScrollView(
    in cell: UICollectionViewCell,
    _ scrollView: UIScrollView) {
    let isHidden = navigationBar.alpha == 0.0
    UIView.animate(withDuration: 0.25) { [weak self] in
      self?.navigationBar.alpha = isHidden ? 1.0 : 0.0
    }
  }
}

extension DetailViewController {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let page = Int(scrollView.contentOffset.x / Device.width)
    interactor?.fetchPaging(request: .init(index: page))
  }
}
