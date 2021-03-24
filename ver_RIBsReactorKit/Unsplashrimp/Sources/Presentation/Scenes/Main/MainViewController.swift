//
//  MainViewController.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

// MARK: - MainPresentableAction
enum MainPresentableAction {
  case detachAction
}

// MARK: - MainPresentableListener
protocol MainPresentableListener: class {
  typealias Action = MainPresentableAction
  typealias State = MainPresentableState
  
  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - MainViewController
final class MainViewController:
  UITabBarController,
  MainPresentable,
  MainViewControllable
{
  // MARK: - Constants
  
  // MARK: - Properties
  
  weak var listener: MainPresentableListener?
  
  private let detachActionRelay = PublishRelay<Void>()
  
  // MARK: - UI Components
  
  // MARK: - Con(De)structor
  init(_ viewControllers: [UIViewController]) {
    super.init(nibName: nil, bundle: nil)
    setViewControllers(viewControllers, animated: false)
    modalPresentationStyle = .fullScreen
    modalTransitionStyle = .crossDissolve
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
private extension MainViewController {
  func bind(to listener: MainPresentableListener?) {
    guard let listener = listener else { return }
    bindDetachAction(to: listener)
  }
  
  func bindDetachAction(to listener: MainPresentableListener) {
    detachActionRelay
      .map { .detachAction }
      .bind(to: listener.action)
      .disposed(by: rx.disposeBag)
  }
}

// MARK: - SetupUI
private extension MainViewController {
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

// MARK: - MainPresentable
extension MainViewController {
  
}

// MARK: - MainViewControllable
extension MainViewController {
}
