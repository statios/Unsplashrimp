//
//  SearchViewControllerTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/14.
//

import XCTest

@testable import Unsplashrimp

final class SearchViewControllerTests: XCTestCase {
  
  // MARK: Test Double Objects
  final class SearchInteractorSpy: SearchBusinessLogic {
    var isCalledFetchSearch = false
    var isCalledFetchPagination = false
    var isCalledFetchSelectPhoto = false
    
    func fetchSearch(request: SearchModels.Search.Request) {
      isCalledFetchSearch = true
    }
    
    func fetchPagination(request: SearchModels.Pagination.Request) {
      isCalledFetchPagination = true
    }
    
    func fetchSelectPhoto(request: SearchModels.SelectPhoto.Request) {
      isCalledFetchSelectPhoto = true
    }
  }
  
  final class SearchRouterSpy: SearchRoutingLogic, SearchDataPassing {
    var dataStore: SearchDataStore?
    
    var isCalledRouteToDetail = false
    
    func routeToDetail() {
      isCalledRouteToDetail = true
    }
  }
  
  // MARK: Properties
  var viewController: SearchViewController!
  var interactor: SearchInteractorSpy!
  var router: SearchRouterSpy!
  
  override func setUp() {
    self.viewController = UIStoryboard("Search").viewController as? SearchViewController
    self.interactor = SearchInteractorSpy()
    self.router = SearchRouterSpy()
    self.viewController.interactor = self.interactor
    self.viewController.router = self.router
    viewController.loadView()
  }
}

// MARK: - Tests
extension SearchViewControllerTests {
  func test_callingFetchSearch() {
    // Given
    
    // When
    viewController.searchBarSearchButtonClicked(
      viewController.searchController.searchBar
    )
    
    // Then
    XCTAssert(interactor.isCalledFetchSearch )
  }
  
  func test_callingFetchPagination() {
    // Given
    viewController.photos = Seeds.photos.first ?? []
    
    // When
    viewController.tableView(
      viewController.tableView,
      willDisplay: UITableViewCell(),
      forRowAt: .init(row: 1, section: 0)
    )
    
    // Then
    XCTAssert(interactor.isCalledFetchPagination)
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
  
}

