//
//  UnsplashAPI.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

enum UnsplashAPI {
  case topics
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
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .topics: return .get
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    default: return []
    }
  }
  
  var header: [String: String] {
    var header: [String: String] = [:]
    if let path = Bundle.main.path(forResource: "Key", ofType: "plist") {
      if let dict = NSDictionary(contentsOfFile: path) {
        let token = dict["UNSPLASH_ACCESS_KEY"] as? String
        header["Authorization"] = "Client-ID " + (token ?? "")
      }
    }
    return header
  }
}
