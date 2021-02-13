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
    var isCalledPresentPrefetch = false
    func presentPrefetch(response: SplashModels.Prefetch.Response) {
      isCalledPresentPrefetch = true
    }
  }

  final class NetworkWorkerSpy: NetworkWorkerLogic {
    var isCalledRequest = false
    func request<T: Codable>(
      _ target: TargetType,
      type: T.Type,
      completion: @escaping (Result<T, Error>) -> Void
    ) {
      isCalledRequest = true
    }
  }


  // MARK: Properties
  var interactor: SplashInteractor!
  var presenter: SplashPresenterSpy!
  var networkWorker: NetworkWorkerSpy!

  override func setUp() {
    self.interactor = SplashInteractor()
    self.presenter = SplashPresenterSpy()
    self.networkWorker =  NetworkWorkerSpy()
    self.interactor.presenter = self.presenter
    self.interactor.networkWorker = self.networkWorker
  }
}


// MARK: - TODO TestName (BDD)
extension SplashInteractorTests {
  func test_callingNetworkRequestWhenRequestPrefetch() {
    // Given
    let dummyRequest = SplashModels.Prefetch.Request()

    // When
    interactor.fetchPrefetch(request: dummyRequest)

    // Then
    XCTAssert(networkWorker.isCalledRequest)
  }
}
