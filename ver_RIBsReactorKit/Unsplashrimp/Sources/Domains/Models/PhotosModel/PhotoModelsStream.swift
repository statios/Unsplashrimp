//
//  PhotosModelDataStream.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/26.
//

import Foundation

import RxSwift
import RxCocoa

protocol PhotoModelsStream {
  var photoModels: Observable<[PhotoModel]> { get }
}

protocol MutablePhotoModelsStream: PhotoModelsStream {
  func updatePhotoModels(with photoModels: [PhotoModel])
  func appendPhotoModels(with photoModels: [PhotoModel])
}

final class PhotoModelsStreamImpl: MutablePhotoModelsStream {
  
  private let _photoModels = BehaviorRelay<[PhotoModel]>(value: [])
  lazy var photoModels: Observable<[PhotoModel]> = _photoModels.asObservable()
  
  func updatePhotoModels(with photoModels: [PhotoModel]) {
    _photoModels.accept(photoModels)
  }
  
  func appendPhotoModels(with photoModels: [PhotoModel]) {
    var newPhotoModels = _photoModels.value
    newPhotoModels.append(contentsOf: photoModels)
    _photoModels.accept(newPhotoModels)
  }
  
}
