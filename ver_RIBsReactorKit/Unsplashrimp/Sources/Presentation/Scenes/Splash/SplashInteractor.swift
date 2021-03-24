//
//  SplashInteractor.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import Foundation
import RIBs
import Moya
import ReactorKit

// MARK: - SplashRouting
protocol SplashRouting: ViewableRouting {
}

// MARK: - SplashPresentable
protocol SplashPresentable: Presentable {
  var listener: SplashPresentableListener? { get set }
}

// MARK: - SplashListener
protocol SplashListener: class {
  func detachSplashRIB()
}

// MARK: - SplashInteractor
final class SplashInteractor:
  PresentableInteractor<SplashPresentable>,
  SplashInteractable,
  SplashPresentableListener,
  Reactor
{
  
  // MARK: - Types
  
  typealias Action = SplashPresentableAction
  
  typealias State = SplashPresentableState
  
  enum Mutation {
    case detach
  }
  
  // MARK: - Properties
  
  weak var router: SplashRouting?
  
  weak var listener: SplashListener?
  
  let initialState: State
  
  // MARK: - Con(De)structor
  
  init(
    initialState: State,
    presenter: SplashPresentable
  ) {
    self.initialState = initialState
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: Reactor
extension SplashInteractor {
  
  // MARK: - mutate
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .detachAction:
      return .just(.detach)
    }
  }
  
  // MARK: - Transform mutation
  
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    return mutation
      .flatMap { [weak self] mutation -> Observable<Mutation> in
        guard let this = self else { return .never() }
        switch mutation {
        case .detach:
          return this.detachSplashRIBTransform()
        }
    }
  }
  
  private func detachSplashRIBTransform() -> Observable<Mutation> {
    listener?.detachSplashRIB()
    return .empty()
  }
  
  // MARK: - reduce
  
  func reduce(
    state: State,
    mutation: Mutation
  ) -> State {
    let newState = state
    switch mutation {
    case .detach:
      logDebug("route logic: \(mutation)")
    }
    return newState
  }
}

// MARK: - SplashInteractable
extension SplashInteractor {
}

// MARK: - SplashPresentableListener
extension SplashInteractor {
}
