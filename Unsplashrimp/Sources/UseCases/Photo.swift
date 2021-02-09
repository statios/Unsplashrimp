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
  
  struct URLs: Codable {
    let thumb: String
    let small: String
    let regular: String
    let full: String
  }
  
  struct User: Codable {
    let name: String
  }
}
