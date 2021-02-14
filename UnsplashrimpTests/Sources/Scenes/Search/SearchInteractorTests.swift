//
//  SearchInteractorTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/14.
//

import XCTest

@testable import Unsplashrimp

final class SearchInteractorTests: XCTestCase {

  // MARK: Test Double Objects
  final class SearchPresenterSpy: SearchPresentationLogic {
    func presentSearch(response: SearchModels.Search.Response) {
      
    }
    
    func presentPagination(response: SearchModels.Pagination.Response) {
      
    }
    
    func presentSelectPhoto(resposne: SearchModels.SelectPhoto.Response) {
      
    }

    func presentErrorMessage(resposne: SearchModels.ErrorMessage.Response) {
      
    }
  }

  final class NetworkWorkerSpy: NetworkWorkerLogic {

  }

  // MARK: Properties
  
  var interactor: SearchInteractor!
  var presenter: SearchPresenterSpy!
  var networkWorker: NetworkWorkerSpy!

  override func setUp() {
    self.interactor = SearchInteractor()
    self.presenter = SearchPresenterSpy()
    self.networkWorker = NetworkWorkerSpy()
    self.interactor.presenter = self.presenter
    self.interactor.networkWorker = self.networkWorker
  }
}

// MARK: - Tests
extension SearchInteractorTests {

  func test_doSomething() {
    // given

    // when

    // then
  }
}
