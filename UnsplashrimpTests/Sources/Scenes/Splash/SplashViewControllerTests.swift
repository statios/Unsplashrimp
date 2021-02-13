//
//  SplashViewControllerTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/13.
//

import XCTest

@testable import Unsplashrimp

final class SplashViewControllerTests: XCTestCase {

  // MARK: Test Double Objects
  final class SplashInteractorSpy: SplashBusinessLogic {
    var isCalledFetchPrefetch = false
    
    func fetchPrefetch(request: SplashModels.Prefetch.Request) {
      isCalledFetchPrefetch = true
    }
  }

  final class SplashRouterSpy: SplashRoutingLogic, SplashDataPassing {
    var dataStore: SplashDataStore?
    
    func routeToExplore() {
      
    }
  }


  // MARK: Properties
  var viewController: SplashViewController!
  var interactor: SplashInteractorSpy!
  var router: SplashRouterSpy!

  override func setUp() {
    self.viewController = SplashViewController()
    self.interactor = SplashInteractorSpy()
    self.router = SplashRouterSpy()
    self.viewController.interactor = self.interactor
    self.viewController.router = self.router
  }
}


// MARK: - TODO TestName (BDD)

extension SplashViewControllerTests {

  func test_callingFetchPrefetch() {
    // Given - Not required

    // When
    viewController.viewWillAppear(false)

    // Then
    XCTAssert(interactor.isCalledFetchPrefetch)
  }
}

