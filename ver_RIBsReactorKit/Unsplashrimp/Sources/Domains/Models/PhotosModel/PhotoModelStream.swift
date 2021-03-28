//
//  PhotoModelStream.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/28.
//

import Foundation

import RxSwift
import RxCocoa

protocol PhotoModelStream {
  var photoModel: Observable<PhotoModel> { get }
}

protocol MutablePhotoModelStream: PhotoModelStream {
  func updatePhotoModel(with photoModel: PhotoModel)
}

final class PhotoModelStreamImpl: MutablePhotoModelStream {
  
  private let _photoModel = BehaviorRelay<PhotoModel?>(value: nil)
  lazy var photoModel: Observable<PhotoModel> = _photoModel.asObservable().compactMap { $0 }
  
  func updatePhotoModel(with photoModel: PhotoModel) {
    _photoModel.accept(photoModel)
  }
  
}

