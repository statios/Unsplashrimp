//
//  ExploreViewController.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift
import RxViewController

// MARK: - ExplorePresentableAction
enum ExplorePresentableAction {
  case refresh
  case display(IndexPath)
  case select(PhotoModel)
  case detachAction
}

// MARK: - ExplorePresentableListener
protocol ExplorePresentableListener: class {
  typealias Action = ExplorePresentableAction
  typealias State = ExplorePresentableState
  
  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - ExploreViewController
final class ExploreViewController:
  UIViewController,
  ExplorePresentable,
  ExploreViewControllable
{
  // MARK: - Constants
  
  // MARK: - Properties
  
  weak var listener: ExplorePresentableListener?
  
  private let detachActionRelay = PublishRelay<Void>()
  
  // MARK: - UI Components
  
  let tableView = UITableView()
  let indicatorView = UIActivityIndicatorView()
  
  // MARK: - Con(De)structor
  
  init() {
    super.init(nibName: nil, bundle: nil)
    title = "Explore"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit { logInfo("deinit: \(self)") }
  
  // MARK: - Overridden: UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind(to: listener) //TODO: listener check
    setupUI()
  }
  
  // MARK: - Internal methods
  
  // MARK: - Private methods
  
  // MARK: - Selectors
}

// MARK: - Binding
private extension ExploreViewController {
  func bind(to listener: ExplorePresentableListener?) {
    guard let listener = listener else { return }
    bindActions(to: listener)
    bindState(from: listener)
  }
  
  // MARK: - Binding Action
  
  func bindActions(to listener: ExplorePresentableListener) {
    bindViewWillAppear(to: listener)
    bindWillDisplayCell(to: listener)
    bindDetachAction(to: listener)
    bindModelSelected(to: listener)
  }
  
  func bindViewWillAppear(to listener: ExplorePresentableListener) {
    rx.viewWillAppear
      .take(1)
      .map { _ in .refresh }
      .bind(to: listener.action)
      .disposed(by: rx.disposeBag)
  }
  
  func bindWillDisplayCell(to listener: ExplorePresentableListener) {
    tableView.rx.willDisplayCell
      .map { .display($0.indexPath) }
      .bind(to: listener.action)
      .disposed(by: rx.disposeBag)
  }
  
  func bindModelSelected(to listener: ExplorePresentableListener) {
    tableView.rx.modelSelected(PhotoModel.self)
      .map { .select($0) }
      .bind(to: listener.action)
      .disposed(by: rx.disposeBag)
  }
  
  func bindDetachAction(to listener: ExplorePresentableListener) {
    detachActionRelay
      .map { .detachAction }
      .bind(to: listener.action)
      .disposed(by: rx.disposeBag)
  }
  
  // MARK: - Binding State
  
  func bindState(from listener: ExplorePresentableListener) {
    bindLoadingState(from: listener)
    bindPhotosState(from: listener)
  }
  
  func bindLoadingState(from listener: ExplorePresentableListener) {
    listener.state.map { $0.isLoading }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] in
        guard let indicatorView = self?.indicatorView else { return }
        $0 ? indicatorView.startAnimating() : indicatorView.stopAnimating()
      }).disposed(by: rx.disposeBag)
  }
  
  func bindPhotosState(from listener: ExplorePresentableListener) {
    listener.state.map { $0.photos }
      .distinctUntilChanged()
      .bind(
        to: tableView.rx.items(
          cellIdentifier: "PhotoListCell",
          cellType: PhotoListCell.self
        )
      ) { (index, viewModel, cell) in
        cell.configure(by: viewModel)
      }.disposed(by: rx.disposeBag)
  }
}

// MARK: - SetupUI
private extension ExploreViewController {
  func setupUI() {
    navigationController?.do {
      $0.hidesBarsOnSwipe = true
    }
    
    tableView.do {
      $0.estimatedRowHeight = UITableView.automaticDimension
      $0.register(
        PhotoListCell.self,
        forCellReuseIdentifier: "PhotoListCell"
      )
    }
    
    indicatorView.do {
      $0.style = .large
    }
    
    layout()
    setupProperties()
  }
  
  func layout() {
    tableView
      .add(to: view)
      .snp.makeConstraints { (make) in
        make.edges.equalToSuperview()
      }
    
    indicatorView
      .add(to: view)
      .snp.makeConstraints { (make) in
        make.center.equalToSuperview()
      }
  }
  
  func setupProperties() {
    view.backgroundColor = .white
  }
}

// MARK: - ExplorePresentable
extension ExploreViewController {
  
}

// MARK: - ExploreViewControllable
extension ExploreViewController {
}
