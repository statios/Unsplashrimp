//
//  SearchInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol SearchDataStore: class {

}

protocol SearchBusinessLogic: class {

}

final class SearchInteractor: BaseInteractor, SearchDataStore {

  var worker: SearchWorkerLogic?
  var presenter: SearchPresentationLogic?

}

// MARK: - Business Logic
extension SearchInteractor: SearchBusinessLogic {

}
