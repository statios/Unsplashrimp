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
  var pages: [Int] { get set }
}

protocol ExploreBusinessLogic: class {
  func fetchTopics(request: ExploreModels.Topics.Request)
  func fetchPhotos(request: ExploreModels.Photos.Request)
  func fetchPagination(request: ExploreModels.Pagination.Request)
}

final class ExploreInteractor: BaseInteractor, ExploreDataStore {
  
  var networkWorker: NetworkWorkerLogic?
  var presenter: ExplorePresentationLogic?
  
  var topics: [Topic] = []
  var photos: [[Photo]] = []
  var pages: [Int] = []
}

// MARK: - Business Logic
extension ExploreInteractor: ExploreBusinessLogic {
  func fetchTopics(request: ExploreModels.Topics.Request) {
    pages = topics.map { _ in Int(1) }
    presenter?.presentTopics(response: .init(topics: topics))
  }
  
  func fetchPhotos(request: ExploreModels.Photos.Request) {
    presenter?.presentPhotos(response: .init(photos: photos))
  }
  
  func fetchPagination(request: ExploreModels.Pagination.Request) {
    networkWorker?
      .request(
        UnsplashAPI.photos(id: topics[request.index].id, page: pages[request.index] + 1),
        type: [Photo].self) { [weak self] in
        switch $0 {
        case .success(let photos):
          self?.pages[request.index] += 1
          self?.presenter?.presentPagination(
            response: .init(index: request.index, photos: photos)
          )
        case .failure(let error):
          return
        }
      }
  }
}
