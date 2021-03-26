//
//  Photo.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/09.
//

import Foundation
import UIKit

struct Photo: Codable {
  let id: String
  let urls: URLs
  let width: CGFloat
  let height: CGFloat
  let user: User
  let color: String
  let blurHash: String
  
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
    case urls
    case width
    case height
    case user
    case color
    case blurHash = "blur_hash"
  }
}
