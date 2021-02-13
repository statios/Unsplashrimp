//
//  UnsplashAPI.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

enum UnsplashAPI {
  case topics
  case photos(id: String, page: Int)
  case search(query: String, page: Int)
}

extension UnsplashAPI: TargetType {
  var scheme: String {
    return "https"
  }
  
  var host: String {
    return "api.unsplash.com"
  }
  
  var path: String {
    switch self {
    case .topics: return "/topics"
    case .photos(let id, _): return "/topics/\(id)/photos"
    case .search: return "/search/photos"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .topics, .photos, .search: return .get
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .photos(_, let page):
      return [
        .init(name: "page", value: String(page)),
      ]
    case .search(let query, let page):
      return [
        .init(name: "query", value: String(query)),
        .init(name: "page", value: String(page))
      ]
    default: return []
    }
  }
  
  var header: [String: String] {
    var header: [String: String] = [:]
    if let path = Bundle.main.path(forResource: "Key", ofType: "plist") {
      if let dict = NSDictionary(contentsOfFile: path) {
        let token = dict["UNSPLASH_ACCESS_KEY"] as? String
        header["Authorization"] = "Client-IDd " + (token ?? "")
      }
    }
    return header
  }
}
