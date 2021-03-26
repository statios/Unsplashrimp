//
//  DetailRoutableDataSource.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/12.
//

import Foundation

protocol DetailRoutableDataStore: class {
  var selectedPhotoIndex: Int { get set }
  var photos: [Photo] { get }
}
