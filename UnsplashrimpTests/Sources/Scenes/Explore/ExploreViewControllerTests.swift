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
    
    var isCalledRouteToDetail = false
    
    func routeToDetail() {
      isCalledRouteToDetail = true
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
    let dummy = Seeds.topics
    
    // When
    viewController.displayTopics(viewModel: .init(topics: dummy))
    
    // Then
    XCTAssert(interactor.isCalledFetchPhotos)
  }
  
  func test_callingFetchPagination() {
    // Given
    viewController.topics = Seeds.topics
    viewController.photos = Seeds.photos

    // When
    viewController.tableView(
      viewController.tableView,
      willDisplay: UITableViewCell(),
      forRowAt: .init(row: 1, section: 0)
    )

    // Then
    XCTAssert(interactor.isCalledFetchPagination)
  }

  func test_callingFetchSelectTopic() {
    // Given

    // When
    viewController.collectionView(
      viewController.collectionView,
      didSelectItemAt: .init(row: 1, section: 0)
    )

    // Then
    XCTAssert(interactor.isCalledFetchSelectTopic)
  }

  func test_callingFetchSelectPhoto() {
    // Given

    // When
    viewController.tableView(
      viewController.tableView,
      didSelectRowAt: .init(row: 0, section: 0)
    )

    // Then
    XCTAssert(interactor.isCalledFetchSelectPhoto)
  }
  
  func test_callingRouteToDetail() {
    // Given
    
    // When
    viewController.displaySelectPhoto(viewModel: .init())
    
    // Then
    XCTAssert(router.isCalledRouteToDetail)
  }
}

