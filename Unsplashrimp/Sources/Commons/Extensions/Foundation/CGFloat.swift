//
//  CGFloat.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/10.
//

import Foundation
import UIKit

extension CGSize {
  func toRatioSizedHeight() -> CGFloat {
    return (height / width) * Device.width
  }
}
