//
//  Search.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import Foundation

struct PaginationResponse<T: Codable>: Codable {
  let total: Int
  let totalPages: Int
  let results: [T]
  
  enum CodingKeys: String, CodingKey {
    case total
    case totalPages = "total_pages"
    case results
  }
}
