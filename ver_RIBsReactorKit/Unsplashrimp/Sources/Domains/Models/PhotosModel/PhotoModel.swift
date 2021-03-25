//
//  PhotosModel.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/26.
//

import Foundation
import UIKit

struct PhotoModel {
  let id: String
  let width: Int
  let height: Int
  let color: String
  let urls: URLs
  let user: User
}

extension PhotoModel: Equatable {
  static func == (lhs: PhotoModel, rhs: PhotoModel) -> Bool {
    lhs.id == rhs.id
  }
}
