//
//  SearchPresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SearchPresentationLogic: class {
  func presentSearch(response: SearchModels.Search.Response)
  func presentPagination(response: SearchModels.Pagination.Response)
  func presentSelectPhoto(resposne: SearchModels.SelectPhoto.Response)
}

final class SearchPresenter: BasePresenter {
  
  weak var view: SearchDisplayLogic?

}

// MARK: - Present
extension SearchPresenter: SearchPresentationLogic {
  func presentSearch(response: SearchModels.Search.Response) {
    view?.displaySearch(
      viewModel: .init(photos: response.search.results)
    )
  }
  
  func presentPagination(response: SearchModels.Pagination.Response) {
    view?.displayPagination(
      viewModel: .init(photos: response.search.results)
    )
  }
  
  func presentSelectPhoto(resposne: SearchModels.SelectPhoto.Response) {
    view?.displaySelectPhoto(viewModel: .init())
  }
}
