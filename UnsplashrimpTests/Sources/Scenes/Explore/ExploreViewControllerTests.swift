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
    var isCalledFetchTopics = false
    var isCalledFetchPhotos = false
    var isCalledFetchPagination = false
    var isCalledFetchSelectTopic = false
    var isCalledFetchSelectPhoto = false

    func fetchTopics(request: ExploreModels.Topics.Request) {
      isCalledFetchTopics = true
    }
    
    func fetchPhotos(request: ExploreModels.Photos.Request) {
      isCalledFetchPhotos = true
    }
    
    func fetchPagination(request: ExploreModels.Pagination.Request) {
      isCalledFetchPagination = true
    }
    
    func fetchSelectTopic(request: ExploreModels.SelectTopic.Request) {
      isCalledFetchSelectTopic = true
    }
    
    func fetchSelectPhoto(request: ExploreModels.SelectPhoto.Request) {
      isCalledFetchSelectPhoto = true
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
    self.viewController = UIStoryboard("Explore").viewController as? ExploreViewController
    self.interactor = ExploreInteractorSpy()
    self.router = ExploreRouterSpy()
    self.viewController.interactor = self.interactor
    self.viewController.router = self.router
    self.viewController.loadView()
  }
}

// MARK: - Tests
extension ExploreViewControllerTests {
  func test_callingFetchTopics() {
    // Given
    
    // When
    viewController.viewDidLoad()
    
    // Then
    XCTAssert(interactor.isCalledFetchTopics)
  }
  
  func test_callingFetchPhotos() {
    // Given
    let dummy = [Topic]()
    
    // When
    viewController.displayTopics(viewModel: .init(topics: dummy))
    
    // Then
    XCTAssert(interactor.isCalledFetchPhotos)
  }
  
//  func test_callingFetchPagination() {
//    // Given
//    viewController.
//    
//    // When
//    viewController.tableView.prefetchDataSource?.tableView(
//      viewController.tableView,
//      prefetchRowsAt: [index]
//    )
//    
//    // Then
//    XCTAssert(interactor.isCalledFetchPagination)
//  }
//  
//  func test_callingFetchSelectTopic() {
//    // Given
//    
//    
//    // When
//    
//    
//    // Then
//    XCTAssert(interactor.isCalledFetchSelectTopic)
//  }
//  
//  func test_callingFetchSelectPhoto() {
//    // Given
//    
//    // When
//    
//    
//    // Then
//    XCTAssert(interactor.isCalledFetchSelectPhoto)
//  }
}

