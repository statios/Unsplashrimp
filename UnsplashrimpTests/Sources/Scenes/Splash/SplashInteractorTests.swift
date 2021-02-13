//
//  SplashInteractorTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/13.
//

import XCTest

@testable import Unsplashrimp

final class SplashInteractorTests: XCTestCase {

  // MARK: Test Double Objects

  final class SplashPresenterSpy: SplashPresentationLogic {
    func presentPrefetch(response: SplashModels.Prefetch.Response) {
      
    }
  }

  final class SplashWorkerSpy: SplashWorkerLogic {

    // var somethingCalled: Int = 0
    // var somethingStub: Value?

    // func something() { ... }
  }


  // MARK: Properties
  
  var interactor: SplashInteractor!
  var presenter: SplashPresenterSpy!
  var worker: SplashWorkerSpy!

  override func setUp() {
    self.interactor = SplashInteractor()
    self.presenter = SplashPresenterSpy()
    self.worker =  SplashWorkerSpy()
    self.interactor.presenter = self.presenter
//    self.interactor.worker = self.worker
  }
}


// MARK: - TODO TestName (BDD)

extension SplashInteractorTests {

  func test_doSomething() {
    // given

    // when

    // then
  }
}
