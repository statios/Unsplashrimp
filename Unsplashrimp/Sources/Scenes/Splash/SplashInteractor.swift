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
  
  var worker: NetworkWorkerLogic?
  var presenter: SplashPresentationLogic?
  
  fileprivate let prefetchGroup = DispatchGroup()
  
  var topics: [Topic] = []
  var photos: [[Photo]] = []
}

// MARK: - Business Logic
extension SplashInteractor: SplashBusinessLogic {
  func fetchPrefetch(request: SplashModels.Prefetch.Request) {
    worker?.request(
      UnsplashAPI.topics,
      type: [Topic].self) { [weak self] in
      switch $0 {
      case let .success(topics):
        self?.topics = topics
        topics.forEach {
          self?.prefetchGroup.enter()
          self?.fetchPhotos($0)
        }
        self?.prefetchGroup.notify(queue: .main) {
          Log.debug("Prefetch Done")
          self?.presenter?.presentPrefetch(response: .init())
        }
      case let .failure(error):
        //TODO:
        return
      }
    }
  }
}

extension SplashInteractor {
  func fetchPhotos(_ topic: Topic) {
    self.worker?.request(
      UnsplashAPI.photos(id: topic.id, page: 1),
      type: [Photo].self
    ) {
      switch $0 {
      case let .success(photos):
        photos.forEach { $0.urls.regular.cacheImage() }
        self.photos.append(photos)
        self.prefetchGroup.leave()
      default: return
      }
    }
  }
}
