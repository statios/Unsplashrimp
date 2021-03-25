//
//  ExploreInteractor.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import Foundation
import RIBs
import Moya
import ReactorKit

// MARK: - ExploreRouting
protocol ExploreRouting: ViewableRouting {
}

// MARK: - ExplorePresentable
protocol ExplorePresentable: Presentable {
  var listener: ExplorePresentableListener? { get set }
}

// MARK: - ExploreListener
protocol ExploreListener: class {
  func detachExploreRIB()
}

// MARK: - ExploreInteractor
final class ExploreInteractor:
  PresentableInteractor<ExplorePresentable>,
  ExploreInteractable,
  ExplorePresentableListener,
  Reactor
{
  
  // MARK: - Types
  
  typealias Action = ExplorePresentableAction
  typealias State = ExplorePresentableState
  
  enum Mutation {
    case detach
  }
  
  // MARK: - Properties
  
  weak var router: ExploreRouting?
  weak var listener: ExploreListener?
  
  let initialState: State
  
  private let unsplashUseCase: UnsplashUseCase
  
  // MARK: - Con(De)structor
  
  init(
    initialState: State,
    unsplashUseCase: UnsplashUseCase,
    presenter: ExplorePresentable
  ) {
    self.initialState = initialState
    self.unsplashUseCase = unsplashUseCase
    
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: Reactor
extension ExploreInteractor {
  
  // MARK: - mutate
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .loadData:
      return .empty()//TODO: 
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
          return this.detachExploreRIBTransform()
        }
    }
  }
  
  private func detachExploreRIBTransform() -> Observable<Mutation> {
    listener?.detachExploreRIB()
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

// MARK: - ExploreInteractable
extension ExploreInteractor {
}

// MARK: - ExplorePresentableListener
extension ExploreInteractor {
}
