//
//  ExploreViewControllerTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/14.
//

import XCTest

@testable import Unsplashrimp

final class ExploreViewControllerTests: XCTestCase {
  // MARK: Test Double Objects
  final class ExploreInteractorSpy: ExploreBusinessLogic {
    func fetchTopics(request: ExploreModels.Topics.Request) {
      
    }
    
    func fetchPhotos(request: ExploreModels.Photos.Request) {
      
    }
    
    func fetchPagination(request: ExploreModels.Pagination.Request) {
      
    }
    
    func fetchSelectTopic(request: ExploreModels.SelectTopic.Request) {
      
    }
    
    func fetchSelectPhoto(request: ExploreModels.SelectPhoto.Request) {
      
    }
  }

  final class ExploreRouterSpy: ExploreRoutingLogic, ExploreDataPassing {
    var dataStore: ExploreDataStore?
    
    func routeToDetail() {
      
    }
  }

  // MARK: Properties
  var viewController: ExploreViewController!
  var interactor: ExploreInteractorSpy!
  var router: ExploreRouterSpy!

  override func setUp() {
    self.viewController = ExploreViewController()
    self.interactor = ExploreInteractorSpy()
    self.router = ExploreRouterSpy()
    self.viewController.interactor = self.interactor
    self.viewController.router = self.router
  }
}

// MARK: - Tests
extension ExploreViewControllerTests {
  func test_doSomething() {
    // given

    // when

    // then
  }
}

