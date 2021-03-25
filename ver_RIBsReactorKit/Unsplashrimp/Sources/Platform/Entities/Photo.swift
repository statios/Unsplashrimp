//
//  Photo.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/25.
//

import Foundation
import UIKit

struct Photo: Codable {
  
  let id: String
  let width: CGFloat
  let height: CGFloat
  let color: String
  let urls: URLs
  let user: User
  
  struct URLs: Codable {
    let thumb: String
    let small: String
    let regular: String
    let full: String
  }
  
  struct User: Codable {
    let name: String
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case width
    case height
    case color
    case urls
    case user
  }
}

extension Photo: Equatable {
  static func == (lhs: Photo, rhs: Photo) -> Bool {
    lhs.id == rhs.id
  }
}
