//
//  BaseInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

class BaseInteractor {
  init() {
    Log.verbose(String(describing: Self.self))
  }
  
  deinit {
    Log.verbose(String(describing: Self.self))
  }
}
