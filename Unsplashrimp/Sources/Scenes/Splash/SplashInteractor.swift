//
//  SplashInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol SplashDataStore: class {
  var topics: [Topic] { get set }
  var photos: [[Photo]] { get set }
}

protocol SplashBusinessLogic: class {
  func fetchPrefetch(request: SplashModels.Prefetch.Request)
}

final class SplashInteractor: BaseInteractor, SplashDataStore {
  var networkWorker: NetworkWorkerLogic?
  var presenter: SplashPresentationLogic?
  
  fileprivate let prefetchGroup = DispatchGroup()
  
  var topics: [Topic] = []
  var photos: [[Photo]] = []
}

// MARK: - Business Logic
extension SplashInteractor: SplashBusinessLogic {
  func fetchPrefetch(request: SplashModels.Prefetch.Request) {
    requestTopics { [weak self] in
      self?.topics = $0
      self?.photos = $0.map { _ in [Photo]() }
      $0.forEach {
        self?.prefetchGroup.enter()
        self?.fetchPhotos($0)
      }
      self?.prefetchGroup.notify(queue: .main) {
        Log.debug("Prefetch Done")
        self?.presenter?.presentPrefetch(response: .init())
      }
    }
  }
}

// MARK:- Helpers
extension SplashInteractor {
  private func requestTopics(
    onSuccess: @escaping ([Topic]) -> Void
  ) {
    networkWorker?.request(
      UnsplashAPI.topics,
      type: UnsplashResponse<[Topic]>.self
    ) {
      switch $0 {
      case let .success(response):
        guard let successResult = response.successResult else { return }
        onSuccess(successResult)
      case .failure:
        // Do NOTHING
        return
      }
    }
  }
  
  private func requestPhotos(
    id: String,
    page: Int,
    onSuccess: @escaping ([Photo]) -> Void
  ) {
    networkWorker?.request(
      UnsplashAPI.photos(id: id, page: page),
      type: UnsplashResponse<[Photo]>.self
    ) {
      switch $0 {
      case let .success(response):
        guard let successResult = response.successResult else { return }
        onSuccess(successResult)
      case .failure:
        // Do NOTHING
        return
      }
    }
  }
  
  private func fetchPhotos(_ topic: Topic) {
    requestPhotos(id: topic.id, page: 1) { [weak self] in
      let index = self?.topics.enumerated()
        .filter { $0.element.id == topic.id }
        .first?.offset ?? 0
      self?.photos[index] = $0
      self?.prefetchGroup.leave()
    }
  }
}
