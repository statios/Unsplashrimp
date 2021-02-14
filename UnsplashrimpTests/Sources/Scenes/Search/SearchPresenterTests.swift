//
//  SearchPresenterTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/14.
//

import XCTest

@testable import Unsplashrimp

final class SearchPresenterTests: XCTestCase {
  
  // MARK: Test Double Objects
  final class SearchDisplaySpy: SearchDisplayLogic {
    var isCalledDisplaySearch = false
    var isCalledDisplayPagination = false
    var isCalledDisplaySelectPhoto = false
    var isCalledDisplayErrorMessage = false
    var isCalledDisplaySelectedPhoto = false

    func displaySearch(viewModel: SearchModels.Search.ViewModel) {
      isCalledDisplaySearch = true
    }
    
    func displayPagination(viewModel: SearchModels.Pagination.ViewModel) {
      isCalledDisplayPagination = true
    }
    
    func displaySelectPhoto(viewModel: SearchModels.SelectPhoto.ViewModel) {
      isCalledDisplaySelectPhoto = true
    }
    
    func displayErrorMessage(viewModel: SearchModels.ErrorMessage.ViewModel) {
      isCalledDisplayErrorMessage = true
    }
    
    func displaySelectedPhoto(_ index: Int) {
      isCalledDisplaySelectedPhoto = true
    }
  }

  // MARK: Properties
  var presenter: SearchPresenter!
  var display: SearchDisplaySpy!
  
  override func setUp() {
    self.presenter = SearchPresenter()
    self.display = SearchDisplaySpy()
    self.presenter.view = self.display
  }
}

// MARK: - Tests
extension SearchPresenterTests {
  func test_callingDisplaySearch() {
    // Given
    let dummy = SearchModels.Search.Response(search: Seeds.search)
    
    // When
    presenter.presentSearch(response: dummy)
    
    // Then
    XCTAssert(display.isCalledDisplaySearch)
  }
  
  func test_callingDisplayPagination() {
    // Given
    let dummy = SearchModels.Pagination.Response(search: Seeds.search)
    
    // When
    presenter.presentPagination(response: dummy)
    
    // Then
    XCTAssert(display.isCalledDisplayPagination)
  }
  
  func test_callingDisplaySelectPhoto() {
    // Given
    
    // When
    presenter.presentSelectPhoto(resposne: .init())
    
    // Then
    XCTAssert(display.isCalledDisplaySelectPhoto)
  }
  
  func test_callingDisplayErrorMessage() {
    // Given
    let dummy = SearchModels.ErrorMessage.Response(message: "errorMessage")
    
    // When
    presenter.presentErrorMessage(resposne: dummy)
    
    // Then
    XCTAssert(display.isCalledDisplayErrorMessage)
  }
}
