//
//  UnsplashResponse.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/13.
//

import Foundation

struct UnsplashResponse<T: Codable>: Codable {
  let successResult: T?
  let failureResult: UnsplashErrorResult?
  
  init(from decoder: Decoder) throws {
    let values = try decoder.singleValueContainer()
    successResult = try? values.decode(T.self)
    failureResult = try? values.decode(UnsplashErrorResult.self)
  }
}
