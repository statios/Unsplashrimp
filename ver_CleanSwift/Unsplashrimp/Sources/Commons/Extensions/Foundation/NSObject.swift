//
//  NSObject.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/12.
//

import Foundation

extension NSObject {
  static var className: String {
    return String(describing: Self.self)
  }
}
