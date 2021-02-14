//
//  ExplorePresenterTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/14.
//

import XCTest

@testable import Unsplashrimp

final class ExplorePresenterTests: XCTestCase {
  // MARK: Test Double Objects
  final class ExploreDisplaySpy: ExploreDisplayLogic {
    var isCalledDisplayTopics = false
    var isCalledDisplayPhotos = false
    var isCalledDisplayPagination = false
    var isCalledDisplaySelectTopic = false
    var isCalledDisplaySelectPhoto = false
    var isCalledDisplayErrorMessage = false
    var isCalledDisplaySelectedPhoto = false
    
    func displayTopics(viewModel: ExploreModels.Topics.ViewModel) {
      isCalledDisplayTopics = true
    }
    
    func displayPhotos(viewModel: ExploreModels.Photos.ViewModel) {
      isCalledDisplayPhotos = true
    }
    
    func displayPagination(viewModel: ExploreModels.Pagination.ViewModel) {
      isCalledDisplayPagination = true
    }
    
    func displaySelectTopic(viewModel: ExploreModels.SelectTopic.ViewModel) {
      isCalledDisplaySelectTopic = true
    }
    
    func displaySelectPhoto(viewModel: ExploreModels.SelectPhoto.ViewModel) {
      isCalledDisplaySelectPhoto = true
    }
    
    func displayErrorMessage(viewModel: ExploreModels.ErrorMessage.ViewModel) {
      isCalledDisplayErrorMessage = true
    }
    
    func displaySelectedPhoto(_ index: Int) {
      isCalledDisplaySelectedPhoto = true
    }
  }
  
  // MARK: Properties
  var presenter: ExplorePresenter!
  var display: ExploreDisplaySpy!
  
  override func setUp() {
    self.presenter = ExplorePresenter()
    self.display = ExploreDisplaySpy()
    self.presenter.view = self.display
  }
}

// MARK: - Tests
extension ExplorePresenterTests {
  func test_callingDisplayTopics() {
    // Given
    let dummy = Seeds.topics
    
    // When
    presenter.presentTopics(response: .init(topics: dummy))
    
    // Then
    XCTAssert(display.isCalledDisplayTopics)
  }
  
  func test_callingDisplayPhotos() {
    // Given
    let dummy = Seeds.photos
    
    // When
    presenter.presentPhotos(response: .init(photos: dummy))
    
    // Then
    XCTAssert(display.isCalledDisplaySelectPhoto)
  }
  
  func test_callingDisplayPagination() {
    // Given
    guard let dummyPhotos = Seeds.photos.first else {
      XCTAssert(false)
      return
    }
    let dummy = ExploreModels.Pagination.Response(index: 0, photos: dummyPhotos)
    
    // When
    presenter.presentPagination(response: dummy)
    
    // Then
    XCTAssert(display.isCalledDisplayPagination)
  }
  
  func test_callingDisplaySelectTopic() {
    // Given
    let dummy = ExploreModels.SelectTopic.Response(index: 0)
    
    // When
    presenter.presentSelectTopic(resposne: dummy)
    
    // Then
    XCTAssert(display.isCalledDisplaySelectTopic)
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
    let dummy = ExploreModels.ErrorMessage.Response(message: "Error occur")
    
    // When
    presenter.presentErrorMessage(resposne: dummy)
    
    // Then
    XCTAssert(display.isCalledDisplayErrorMessage)
  }
  
  func test_callingDisplaySelectedPhoto() {
    // Given
    
    // When
    
    // Then
    XCTAssert(display.isCalledDisplaySelectedPhoto)
  }
}
