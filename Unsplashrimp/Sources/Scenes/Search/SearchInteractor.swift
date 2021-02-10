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
}

final class SearchInteractor: BaseInteractor, SearchDataStore {

  var networkWorker: NetworkWorkerLogic?
  var presenter: SearchPresentationLogic?

  var query: String = ""
  var page: Int = 0
  
}

// MARK: - Business Logic
extension SearchInteractor: SearchBusinessLogic {
  func fetchSearch(request: SearchModels.Search.Request) {
    page = 1
    networkWorker?.request(
      UnsplashAPI.search(query: request.query, page: page),
      type: PaginationResponse<Photo>.self) { [weak self] in
      switch $0 {
      case .success(let searchResponse):
        self?.presenter?.presentSearch(response: .init(search: searchResponse))
      case .failure(let error):
        //TODO
        return
      }
    }
  }
}
