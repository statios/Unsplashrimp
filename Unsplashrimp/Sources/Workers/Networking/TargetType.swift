//
//  NetworkTargetType.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol TargetType {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem] { get }
  var header: [String: String] { get }
}

extension TargetType {
  var components: URLComponents {
    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.path = path
    components.queryItems = queryItems
    return components
  }
  
  var request: URLRequest {
    guard let url = components.url else { fatalError() }
    var request = URLRequest(url: url)
//    request.allHTTPHeaderFields = header
    return request
  }
}
