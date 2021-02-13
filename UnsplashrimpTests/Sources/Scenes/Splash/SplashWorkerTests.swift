//
//  SplashWorkerTests.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/13.
//

import XCTest

@testable import Unsplashrimp

final class SplashWorkerTests: XCTestCase {

  // MARK: Test Double Objects

  final class SplashWorkerSpy: SplashWorkerLogic {

    // var somethingCalled: Int = 0
    // var somethingStub: Value?

    // func something() { ... }
  }


  // MARK: Properties

  var worker:  SplashWorkerSpy!
  
  override func setUp() {
    self.worker =  SplashWorkerSpy()
  }
}


// MARK: - TODO TestName (BDD)

extension SplashWorkerTests {

  func test_doSomething() {
    // given

    // when

    // then
  }
}
