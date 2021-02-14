//
//  Seeds.swift
//  UnsplashrimpTests
//
//  Created by KIHYUN SO on 2021/02/14.
//

import Foundation

@testable import Unsplashrimp

struct Seeds {
  static let topics: [Topic] = [
    .init(id: "1", slug: "topic1", title: "Topic1"),
    .init(id: "2", slug: "topic2", title: "Topic2"),
  ]
  
  static let photos: [[Photo]] = [
    [
      .init(id: "1", urls: photoURLs, width: 0, height: 0, user: .init(name: "1"), color: "", blurHash: ""),
      .init(id: "1", urls: photoURLs, width: 0, height: 0, user: .init(name: "1"), color: "", blurHash: "")
    ],
    [
      .init(id: "1", urls: photoURLs, width: 0, height: 0, user: .init(name: "1"), color: "", blurHash: ""),
      .init(id: "1", urls: photoURLs, width: 0, height: 0, user: .init(name: "1"), color: "", blurHash: "")
    ]
  ]
  
  static var photoURLs: Photo.URLs = .init(
    thumb: "1", small: "1", regular: "1", full: "1"
  )
  
}
