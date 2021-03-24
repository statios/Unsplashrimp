//
//  ExploreViewController.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

// MARK: - ExplorePresentableAction
enum ExplorePresentableAction {
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
    bind(to: listener)
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
    bindDetachAction(to: listener)
  }
  
  func bindDetachAction(to listener: ExplorePresentableListener) {
    detachActionRelay
      .map { .detachAction }
      .bind(to: listener.action)
      .disposed(by: rx.disposeBag)
  }
}

// MARK: - SetupUI
private extension ExploreViewController {
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

// MARK: - ExplorePresentable
extension ExploreViewController {
  
}

// MARK: - ExploreViewControllable
extension ExploreViewController {
}
