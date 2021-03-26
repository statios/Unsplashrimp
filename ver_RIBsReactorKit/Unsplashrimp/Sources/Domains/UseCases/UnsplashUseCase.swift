//
//  UnsplashUseCase.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/25.
//

import Foundation

import RxSwift

protocol UnsplashUseCase {
  var repository: UnsplashRepository { get }
  var photoModelsStream: PhotoModelsStream { get }
  func loadData() -> Observable<Void>
}

final class UnsplashUseCaseImpl: UnsplashUseCase {
  
  let repository: UnsplashRepository
  
  var photoModelsStream: PhotoModelsStream {
    return _photoModelsStream
  }
  private let _photoModelsStream: MutablePhotoModelsStream
  
  init(repository: UnsplashRepository,
       mutablePhotoModelsStream: MutablePhotoModelsStream) {
    self.repository = repository
    self._photoModelsStream = mutablePhotoModelsStream
  }
  
  func loadData() -> Observable<Void> {
    repository.photos(page: 0, count: nil, order: nil)
      .asObservable()
      .do(onNext: { [weak self] in self?.updatePhotoModels(by: $0) })
      .map { _ in }
  }
  
  private func updatePhotoModels(by results: [Photo]) {
    let photoModels = results.map {
      translatePhotoToPhotoModel(from: $0)
    }
    _photoModelsStream.updatePhotoModels(with: photoModels)
  }
    
  private func appendPhotoModels(by results: [Photo]) {
    let photoModels = results.map {
      translatePhotoToPhotoModel(from: $0)
    }
    _photoModelsStream.appendPhotoModels(with: photoModels)
  }
  
}

extension UnsplashUseCaseImpl {
  private func translatePhotoToPhotoModel(
    from photo: Photo
  ) -> PhotoModel {
    
    PhotoModel(
      id: photo.id,
      width: photo.width,
      height: photo.height,
      color: photo.color,
      urls: photo.urls,
      user: photo.user
    )
  }
}
