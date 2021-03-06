//
//  SearchInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol SearchDataStore: DetailRoutableDataStore {
  var query: String { get set }
  var page: Int { get set }
  var selectedPhotoIndex: Int { get set }
}

protocol SearchBusinessLogic: class {
  func fetchSearch(request: SearchModels.Search.Request)
  func fetchPagination(request: SearchModels.Pagination.Request)
  func fetchSelectPhoto(request: SearchModels.SelectPhoto.Request)
}

final class SearchInteractor: BaseInteractor, SearchDataStore {
  var networkWorker: NetworkWorkerLogic?
  var presenter: SearchPresentationLogic?

  var query: String = ""
  var page: Int = 0
  var totalPage: Int = 0
  var photos: [Photo] = []
  var selectedPhotoIndex: Int = 0
}

// MARK: - Business Logic
extension SearchInteractor: SearchBusinessLogic {
  func fetchSearch(request: SearchModels.Search.Request) {
    query = request.query
    page = 1
    requestSearch(query: query, page: page) { [weak self] in
      self?.totalPage = $0.totalPages
      self?.photos = $0.results
      self?.presenter?.presentSearch(response: .init(search: $0))
    } onFailure: { [weak self] in
      self?.presenter?.presentErrorMessage(
        resposne: .init(message: $0)
      )
    }
  }
  
  func fetchPagination(request: SearchModels.Pagination.Request) {
    guard page < totalPage else {
      Log.error("No more pages")
      return
    }
    requestSearch(query: query, page: page + 1) { [weak self] in
      self?.page += 1
      self?.photos.append(contentsOf: $0.results)
      self?.presenter?.presentPagination(
        response: .init(search: $0)
      )
    } onFailure: { [weak self] in
      self?.presenter?.presentErrorMessage(
        resposne: .init(message: $0)
      )
    }
  }
  
  func fetchSelectPhoto(request: SearchModels.SelectPhoto.Request) {
    selectedPhotoIndex = request.index
    presenter?.presentSelectPhoto(resposne: .init())
  }
}

// MARK:- Helpers
extension SearchInteractor {
  private func requestSearch(
    query: String,
    page: Int,
    onSuccess: @escaping (PaginationResponse<Photo>) -> Void,
    onFailure: @escaping (String?) -> Void
  ) {
    networkWorker?.request(
      UnsplashAPI.search(query: query, page: page),
      type: UnsplashResponse<PaginationResponse<Photo>>.self
    ) {
      switch $0 {
      case .success(let result):
        if let successResult = result.successResult {
          onSuccess(successResult)
        } else if let failureResult = result.failureResult {
          onFailure(failureResult.errors.first)
        }
      case .failure(let error):
        onFailure(error.message)
      }
    }
  }
}
