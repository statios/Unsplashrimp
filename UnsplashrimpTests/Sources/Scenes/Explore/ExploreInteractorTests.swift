//
//  ExploreInteractorTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/14.
//

import XCTest

@testable import Unsplashrimp

final class ExploreInteractorTests: XCTestCase {
  // MARK: Test Double Objects
  final class ExplorePresenterSpy: ExplorePresentationLogic {
    func presentTopics(response: ExploreModels.Topics.Response) {
        
    }
    
    func presentPhotos(response: ExploreModels.Photos.Response) {
      
    }
    
    func presentPagination(response: ExploreModels.Pagination.Response) {
      
    }
    
    func presentSelectTopic(resposne: ExploreModels.SelectTopic.Response) {
      
    }
    
    func presentSelectPhoto(resposne: ExploreModels.SelectPhoto.Response) {
      
    }
    
    func presentErrorMessage(resposne: ExploreModels.ErrorMessage.Response) {
      
    }
  }

  final class NetworkWorkerSpy: NetworkWorkerLogic {

  }

  // MARK: Properties
  var interactor: ExploreInteractor!
  var presenter: ExplorePresenterSpy!
  var networkWorker: NetworkWorkerSpy!

  override func setUp() {
    self.interactor = ExploreInteractor()
    self.presenter = ExplorePresenterSpy()
    self.networkWorker = NetworkWorkerSpy()
    self.interactor.presenter = self.presenter
    self.interactor.networkWorker = self.networkWorker
  }
}

// MARK:- Tests
extension ExploreInteractorTests {
  func test_doSomething() {
    // given

    // when

    // then
  }
}
