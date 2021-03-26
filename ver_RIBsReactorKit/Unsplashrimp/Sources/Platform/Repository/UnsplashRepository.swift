//
//  UnsplashRepository.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/25.
//

import Foundation

import RxSwift

protocol UnsplashRepository {
  var page: Int { get }
  var count: Int { get }
  var order: UnsplashService.Order { get }
  
  func photos(page: Int, count: Int, order: UnsplashService.Order) -> Single<[Photo]>
}

final class UnsplashRepositoryImpl: UnsplashRepository {
  
  private(set) var page: Int = 0
  private(set) var count: Int = 10
  private(set) var order: UnsplashService.Order = .latest
  
  private let service: Networking<UnsplashService>
  private lazy var jsonDecoder = JSONDecoder()
  
  init(service: Networking<UnsplashService>) {
    self.service = service
  }
}

extension UnsplashRepositoryImpl {
  func photos(
    page: Int,
    count: Int,
    order: UnsplashService.Order
  ) -> Single<[Photo]> {
    service
      .request(.photos(page: page, perPage: count, orderBy: order))
      .map([Photo].self, using: jsonDecoder, failsOnEmptyData: false)
      .do(onSuccess: { [weak self] _ in
        guard let this = self else { return }
        this.page = page
        this.count = count
        this.order = order
      })
  }
}
