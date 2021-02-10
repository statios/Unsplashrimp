//
//  SearchPresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SearchPresentationLogic: class {
  func presentSearch(response: SearchModels.Search.Response)
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
}
