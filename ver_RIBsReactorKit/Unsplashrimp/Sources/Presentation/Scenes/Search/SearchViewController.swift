//
//  SearchViewController.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

// MARK: - SearchPresentableAction
enum SearchPresentableAction {
  case detachAction
}

// MARK: - SearchPresentableListener
protocol SearchPresentableListener: class {
  typealias Action = SearchPresentableAction
  typealias State = SearchPresentableState
  
  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - SearchViewController
final class SearchViewController:
  UIViewController,
  SearchPresentable,
  SearchViewControllable
{
  // MARK: - Constants
  
  // MARK: - Properties
  
  weak var listener: SearchPresentableListener?
  
  private let detachActionRelay = PublishRelay<Void>()
  
  // MARK: - UI Components
  
  // MARK: - Con(De)structor
  
  init() {
    super.init(nibName: nil, bundle: nil)
    title = "Search"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit { logInfo("deinit: \(self)") }
  
  // MARK: - Overridden: UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind(to: listener)
    setupUI()
  }
  
  // MARK: - Internal methods
  
  // MARK: - Private methods
  
  // MARK: - Selectors
}

// MARK: - Binding
private extension SearchViewController {
  func bind(to listener: SearchPresentableListener?) {
    guard let listener = listener else { return }
    bindDetachAction(to: listener)
  }
  
  func bindDetachAction(to listener: SearchPresentableListener) {
    detachActionRelay
      .map { .detachAction }
      .bind(to: listener.action)
      .disposed(by: rx.disposeBag)
  }
}

// MARK: - SetupUI
private extension SearchViewController {
  func setupUI() {
    layout()
    setupProperties()
  }
  
  func layout() {
    
  }
  
  func setupProperties() {
    view.backgroundColor = .white
  }
}

// MARK: - SearchPresentable
extension SearchViewController {
  
}

// MARK: - SearchViewControllable
extension SearchViewController {
}
