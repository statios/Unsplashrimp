//
//  SearchInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol SearchDataStore: class {
  var query: String { get set }
  var page: Int { get set }
}

protocol SearchBusinessLogic: class {
  func fetchSearch(request: SearchModels.Search.Request)
  func fetchPagination(request: SearchModels.Pagination.Request)
}

final class SearchInteractor: BaseInteractor, SearchDataStore {

  var networkWorker: NetworkWorkerLogic?
  var presenter: SearchPresentationLogic?

  var query: String = ""
  var page: Int = 0
  var totalPage: Int = 0
  var photos: [Photo] = []
}

// MARK: - Business Logic
extension SearchInteractor: SearchBusinessLogic {
  func fetchSearch(request: SearchModels.Search.Request) {
    self.query = request.query
    self.page = 1
    networkWorker?.request(
      UnsplashAPI.search(query: query, page: page),
      type: PaginationResponse<Photo>.self) { [weak self] in
      switch $0 {
      case .success(let searchResponse):
        self?.totalPage = searchResponse.totalPages
        self?.photos = searchResponse.results
        self?.presenter?.presentSearch(response: .init(search: searchResponse))
      case .failure(let error):
        //TODO
        return
      }
    }
  }
  
  func fetchPagination(request: SearchModels.Pagination.Request) {
    
    guard page < totalPage else {
      Log.error("No more pages")
      return
    }
    
    networkWorker?.request(
      UnsplashAPI.search(query: query, page: page + 1),
      type: PaginationResponse<Photo>.self) { [weak self] in
      switch $0 {
      case .success(let searchResponse):
        self?.page += 1
        self?.photos.append(contentsOf: searchResponse.results)
        self?.presenter?.presentPagination(
          response: .init(search: searchResponse)
        )
      case .failure(let error):
        //TODO
        return
      }
    }
  }
}
