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
    let topic = topics[request.index]
    let page = pages[request.index]
    requestPhotos(id: topic.id, page: page + 1) { [weak self] in
      guard let index = self?.selectedTopicIndex else { return }
      self?.pages[index] += 1
      self?.photosByTopics[index].append(contentsOf: $0)
      self?.presenter?.presentPagination(
        response: .init(index: index, photos: $0)
      )
    } onFailure: { [weak self] in
      self?.presenter?.presentErrorMessage(
        resposne: .init(message: $0)
      )
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

// MARK: - Helpers
extension ExploreInteractor {
  private func requestPhotos(
    id: String,
    page: Int,
    onSuccess: @escaping ([Photo]) -> Void,
    onFailure: @escaping (String?) -> Void
  ) {
    networkWorker?
      .request(
        UnsplashAPI.photos(id: id, page: page),
        type: UnsplashResponse<[Photo]>.self
      ) {
        switch $0 {
        case .success(let result):
          if let photos = result.successResult {
            onSuccess(photos)
          } else if let failureResult = result.failureResult {
            onFailure(failureResult.errors.first)
          }
        case .failure(let error):
          onFailure(error.message)
          return
        }
      }
  }
}
