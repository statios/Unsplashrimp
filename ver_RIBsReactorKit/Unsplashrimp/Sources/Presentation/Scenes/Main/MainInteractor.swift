//
//  MainInteractor.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import Foundation
import RIBs
import Moya
import ReactorKit

// MARK: - MainRouting
protocol MainRouting: ViewableRouting {
  func attatchExploreRIB()
  func detatchExploreRIB()
  func attatchSearchRIB()
  func detatchSearchRIB()
}

// MARK: - MainPresentable
protocol MainPresentable: Presentable {
  var listener: MainPresentableListener? { get set }
}

// MARK: - MainListener
protocol MainListener: class {
  func detachMainRIB()
}

// MARK: - MainInteractor
final class MainInteractor:
  PresentableInteractor<MainPresentable>,
  MainInteractable,
  MainPresentableListener,
  Reactor
{
  
  // MARK: - Types
  typealias Action = MainPresentableAction
  typealias State = MainPresentableState
  
  enum Mutation {
    case detach
  }
  
  // MARK: - Properties
  
  weak var router: MainRouting?
  
  weak var listener: MainListener?
  
  let initialState: State
  
  // MARK: - Con(De)structor
  
  init(
    initialState: State,
    presenter: MainPresentable
  ) {
    self.initialState = initialState
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: Reactor
extension MainInteractor {
  
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
          return this.detachMainRIBTransform()
        }
    }
  }
  
  private func detachMainRIBTransform() -> Observable<Mutation> {
    listener?.detachMainRIB()
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

// MARK: - MainInteractable
extension MainInteractor {
}

// MARK: - MainPresentableListener
extension MainInteractor {
  func detachExploreRIB() {
    router?.detatchExploreRIB()
  }
  
  func detachSearchRIB() {
    router?.detatchSearchRIB()
  }
}
