//
//  ExploreInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol ExploreDataStore: DetailRoutableDataStore {
  var topics: [Topic] { get set }
  var pages: [Int] { get set }
  var selectedTopicIndex: Int { get set }
  var photosByTopics: [[Photo]] { get set }
}

protocol ExploreBusinessLogic: class {
  func fetchTopics(request: ExploreModels.Topics.Request)
  func fetchPhotos(request: ExploreModels.Photos.Request)
  func fetchPagination(request: ExploreModels.Pagination.Request)
  func fetchSelectTopic(request: ExploreModels.SelectTopic.Request)
  func fetchSelectPhoto(request: ExploreModels.SelectPhoto.Request)
}

final class ExploreInteractor: BaseInteractor, ExploreDataStore {
  
  var networkWorker: NetworkWorkerLogic?
  var presenter: ExplorePresentationLogic?
  
  var topics: [Topic] = []
  var photosByTopics: [[Photo]] = []
  var pages: [Int] = []
  var selectedTopicIndex = 0
  var selectedPhotoIndex = 0
  
  var photos: [Photo] {
    return photosByTopics[selectedTopicIndex]
  }
}

// MARK: - Business Logic
extension ExploreInteractor: ExploreBusinessLogic {
  func fetchTopics(request: ExploreModels.Topics.Request) {
    pages = topics.map { _ in Int(1) }
    presenter?.presentTopics(response: .init(topics: topics))
  }
  
  func fetchPhotos(request: ExploreModels.Photos.Request) {
    presenter?.presentPhotos(response: .init(photos: photosByTopics))
  }
  
  func fetchPagination(request: ExploreModels.Pagination.Request) {
    networkWorker?
      .request(
        UnsplashAPI.photos(id: topics[request.index].id, page: pages[request.index] + 1),
        type: UnsplashResponse<[Photo]>.self) { [weak self] in
        self?.pages[request.index] += 1
        switch $0 {
        case .success(let result):
          if let photos = result.successResult {
            self?.photosByTopics[request.index].append(contentsOf: photos)
            self?.presenter?.presentPagination(
              response: .init(index: request.index, photos: photos)
            )
          } else if let failureResult = result.failureResult {
            self?.presenter?.presentErrorMessage(
              resposne: .init(
                message: failureResult.errors.first
              )
            )
          }
        case .failure(let error):
          self?.presenter?.presentErrorMessage(
            resposne: .init(
              message: error.localizedDescription
            )
          )
          return
        }
      }
  }
  
  func fetchSelectTopic(request: ExploreModels.SelectTopic.Request) {
    selectedTopicIndex = request.index
    presenter?.presentSelectTopic(resposne: .init(index: request.index))
  }
  
  func fetchSelectPhoto(request: ExploreModels.SelectPhoto.Request) {
    selectedPhotoIndex = request.index
    presenter?.presentSelectPhoto(resposne: .init())
  }
}
