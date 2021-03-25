//
//  RandomPhotoService.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/25.
//

import Foundation
import Moya

enum UnsplashService {
  
  enum Order: String {
    case latest = "latest"
    case oldest = "oldest"
    case popular = "popular"
  }
  
  case photos(page: Int, perPage: Int?, orderBy: Order?)
}

extension UnsplashService: TargetType {
  var baseURL: URL {
    URL(string: "https://api.unsplash.com")!
  }
  
  var path: String {
    switch self {
    case .photos: return "/photos"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .photos: return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .photos(let page, let perPage, let orderBy):
      return .requestParameters(
        parameters: [
          "page": page,
          "per_page": perPage as Any,
          "order_by": orderBy as Any
        ],
        encoding: URLEncoding.default
      )
    }
  }
  
  var headers: [String: String]? {
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
