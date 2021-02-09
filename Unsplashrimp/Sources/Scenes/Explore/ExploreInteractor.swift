//
//  ExploreInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol ExploreDataStore: class {
  
}

protocol ExploreBusinessLogic: class {
  func fetchTopics(request: ExploreModels.Topics.Request)
  func fetchSelectedTopic(request: ExploreModels.SelectTopic.Request)
}

final class ExploreInteractor: BaseInteractor, ExploreDataStore {
  
  var networkWorker: NetworkWorkerLogic? = NetworkWorker.shared
  var presenter: ExplorePresentationLogic?
  
  var selectedIndexPath: IndexPath?
}

// MARK: - Business Logic
extension ExploreInteractor: ExploreBusinessLogic {
  func fetchTopics(request: ExploreModels.Topics.Request) {
    networkWorker?.request(UnsplashAPI.topics, type: [Topic].self) { [weak self] in
      switch $0 {
      case let .success(topics):
        self?.presenter?.presentTopics(response: .init(topics: topics))
      case let .failure(error):
        //todo
        return
      }
    }
  }
  
  func fetchSelectedTopic(request: ExploreModels.SelectTopic.Request) {
    presenter?.presentSelectedIndexPath(
      response: .init(
        previousSelected: selectedIndexPath,
        currentSelected: request.selected
      )
    )
    selectedIndexPath = request.selected
  }
}
