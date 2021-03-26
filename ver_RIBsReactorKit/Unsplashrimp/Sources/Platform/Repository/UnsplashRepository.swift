//
//  UnsplashRepository.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/25.
//

import Foundation

import RxSwift

protocol UnsplashRepository {
  func photos(
    page: Int,
    count: Int?,
    order: UnsplashService.Order?
  ) -> Single<[Photo]>
}

final class UnsplashRepositoryImpl: UnsplashRepository {
  
  private let service: Networking<UnsplashService>
  private lazy var jsonDecoder = JSONDecoder()
  
  init(service: Networking<UnsplashService>) {
    self.service = service
  }
}

extension UnsplashRepositoryImpl {
  func photos(
    page: Int,
    count: Int?,
    order: UnsplashService.Order?
  ) -> Single<[Photo]> {
    service
      .request(.photos(page: page, perPage: count, orderBy: order))
      .map([Photo].self, using: jsonDecoder, failsOnEmptyData: false)
  }
}
