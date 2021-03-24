//
//  SearchInteractor.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import Foundation
import RIBs
import Moya
import ReactorKit

// MARK: - SearchRouting
protocol SearchRouting: ViewableRouting {
}

// MARK: - SearchPresentable
protocol SearchPresentable: Presentable {
  var listener: SearchPresentableListener? { get set }
}

// MARK: - SearchListener
protocol SearchListener: class {
  func detachSearchRIB()
}

// MARK: - SearchInteractor
final class SearchInteractor:
  PresentableInteractor<SearchPresentable>,
  SearchInteractable,
  SearchPresentableListener,
  Reactor
{
  
  // MARK: - Types
  
  typealias Action = SearchPresentableAction
  
  typealias State = SearchPresentableState
  
  enum Mutation {
    case detach
  }
  
  // MARK: - Properties
  
  weak var router: SearchRouting?
  
  weak var listener: SearchListener?
  
  let initialState: State
  
  // MARK: - Con(De)structor
  
  init(
    initialState: State,
    presenter: SearchPresentable
  ) {
    self.initialState = initialState
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: Reactor
extension SearchInteractor {
  
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
          return this.detachSearchRIBTransform()
        }
    }
  }
  
  private func detachSearchRIBTransform() -> Observable<Mutation> {
    listener?.detachSearchRIB()
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

// MARK: - SearchInteractable
extension SearchInteractor {
}

// MARK: - SearchPresentableListener
extension SearchInteractor {
}
