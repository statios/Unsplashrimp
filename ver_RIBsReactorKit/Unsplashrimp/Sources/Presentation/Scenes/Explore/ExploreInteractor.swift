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
    case setLoading(Bool)
    case loadData
    case setPhotos([PhotoViewModel])
    case detach
  }
  
  // MARK: - Properties
  
  weak var router: ExploreRouting?
  weak var listener: ExploreListener?
  
  let initialState: State
  
  private let unsplashUseCase: UnsplashUseCase
  private let requestItemSize: Int = 10
  
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
    case .refresh: return refreshMutation()
    case .detachAction: return .just(.detach)
    case .display(let indexPath): return displayMutation(by: indexPath)
    }
  }
  
  private func refreshMutation() -> Observable<Mutation> {
    let startLoading = Observable<Mutation>.just(.setLoading(true))
    let endLoading = Observable<Mutation>.just(.setLoading(false))
    let loadPhotoModels = unsplashUseCase.loadPhotoModels(
      isRefresh: true,
      count: requestItemSize,
      order: .latest
    ).map { Mutation.loadData }
    .catchErrorJustReturn(.setLoading(false))
    return .concat([startLoading, loadPhotoModels, endLoading])
  }
  
  private func displayMutation(by indexPath: IndexPath) -> Observable<Mutation> {
    guard indexPath.row == currentState.photos.count - 1 else { return .empty() }
    let startLoading = Observable<Mutation>.just(.setLoading(true))
    let endLoading = Observable<Mutation>.just(.setLoading(false))
    let loadPhotoModels = unsplashUseCase.loadPhotoModels(
      isRefresh: false,
      count: requestItemSize,
      order: .latest
    ).map { Mutation.loadData }
    .catchErrorJustReturn(.setLoading(false))
    return .concat(startLoading, loadPhotoModels, endLoading)
  }
  
  // MARK: - Transform mutation
  
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    return mutation
      .flatMap { [weak self] mutation -> Observable<Mutation> in
        guard let this = self else { return .never() }
        switch mutation {
        case .loadData:
          Log.error("set photos")
          return this.unsplashUseCase.photoModelsStream.photoModels
            .map { $0.map { PhotoViewModel(photoModel: $0) } }
            .map { Mutation.setPhotos($0) }
        case .detach:
          return this.detachExploreRIBTransform()
        default: return .just(mutation)
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
    var newState = state
    switch mutation {
    case .setLoading(let isLoading):
      newState.isLoading = isLoading
    case .setPhotos(let photos):
      newState.photos = photos
    case .loadData:
      Log.debug("Do nothing when \(mutation)")
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
