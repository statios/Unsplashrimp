//
//  SplashViewController.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - SplashPresentableAction
enum SplashPresentableAction {
  case detachAction
}

// MARK: - SplashPresentableListener
protocol SplashPresentableListener: class {
  typealias Action = SplashPresentableAction
  typealias State = SplashPresentableState
  
  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - SplashViewController
final class SplashViewController:
  UIViewController,
  SplashPresentable,
  SplashViewControllable
{
  // MARK: - Constants
  
  // MARK: - Properties
  
  weak var listener: SplashPresentableListener?
  
  private let detachActionRelay = PublishRelay<Void>()
  
  // MARK: - UI Components
  
  let titleLabel = UILabel().then {
    $0.textColor = .black
    $0.text = "Unsplashrimp"
    $0.font = UIFont.boldSystemFont(ofSize: 24)
  }
  
  // MARK: - Con(De)structor
  
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
private extension SplashViewController {
  func bind(to listener: SplashPresentableListener?) {
    guard let listener = listener else { return }
    bindDetachAction(to: listener)
  }
  
  func bindDetachAction(to listener: SplashPresentableListener) {
    detachActionRelay
      .map { .detachAction }
      .bind(to: listener.action)
      .disposed(by: rx.disposeBag)
  }
}

// MARK: - SetupUI
private extension SplashViewController {
  func setupUI() {
    layout()
    setupProperties()
  }
  
  func layout() {
    titleLabel
      .add(to: view)
      .snp.makeConstraints { (make) in
        make.center.equalToSuperview()
      }
  }
  
  func setupProperties() {
    view.backgroundColor = .white
  }
}

// MARK: - SplashPresentable
extension SplashViewController {
  
}

// MARK: - SplashViewControllable
extension SplashViewController {
}
