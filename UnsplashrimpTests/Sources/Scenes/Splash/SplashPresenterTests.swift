//
//  SplashPresenterTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/13.
//

import XCTest

@testable import Unsplashrimp

final class SplashPresenterTests: XCTestCase {
  
  // MARK: Test Double Objects
  
  final class SplashDisplaySpy: SplashDisplayLogic {
    func displayPrefetch(viewModel: SplashModels.Prefetch.ViewModel) {
      
    }
  }
  

  // MARK: Properties
  
  var presenter: SplashPresenter!
  var display: SplashDisplaySpy!
  
  override func setUp() {
    self.presenter = SplashPresenter()
    self.display = SplashDisplaySpy()
    self.presenter.view = self.display
  }
}


// MARK: - TODO TestName (BDD)

extension SplashPresenterTests {
  
  func test_doSomething() {
    // given
    
    // when
    
    // then
  }
}
