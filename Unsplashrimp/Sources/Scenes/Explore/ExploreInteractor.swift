//
//  ExploreInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol ExploreDataStore: class {
  var topics: [Topic] { get set }
  var photos: [[Photo]] { get set }
}

protocol ExploreBusinessLogic: class {
  func fetchTopics(request: ExploreModels.Topics.Request)
  func fetchPhotos(request: ExploreModels.Photos.Request)
}

final class ExploreInteractor: BaseInteractor, ExploreDataStore {
  
  var networkWorker: NetworkWorkerLogic?
  var presenter: ExplorePresentationLogic?
  
  var topics: [Topic] = []
  var photos: [[Photo]] = []
}

// MARK: - Business Logic
extension ExploreInteractor: ExploreBusinessLogic {
  func fetchTopics(request: ExploreModels.Topics.Request) {
    presenter?.presentTopics(response: .init(topics: topics))
  }
  
  func fetchPhotos(request: ExploreModels.Photos.Request) {
    presenter?.presentPhotos(response: .init(photos: photos))
  }
}
