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
    func displayTopics(viewModel: ExploreModels.Topics.ViewModel) {
      
    }
    
    func displayPhotos(viewModel: ExploreModels.Photos.ViewModel) {
      
    }
    
    func displayPagination(viewModel: ExploreModels.Pagination.ViewModel) {
      
    }
    
    func displaySelectTopic(viewModel: ExploreModels.SelectTopic.ViewModel) {
      
    }
    
    func displaySelectPhoto(viewModel: ExploreModels.SelectPhoto.ViewModel) {
      
    }
    
    func displayErrorMessage(viewModel: ExploreModels.ErrorMessage.ViewModel) {
      
    }
    
    func displaySelectedPhoto(_ index: Int) {
      
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
  func test_doSomething() {
    // given
    
    // when
    
    // then
  }
}
