//
//  DetailInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import Foundation

protocol DetailDataStore: class {
  var photos: [Photo] { get set }
  var selectedPhotoIndex: Int { get set }
}

protocol DetailBusinessLogic: class {
  func fetchPhotos(request: DetailModels.Photos.Request)
  func fetchPaging(request: DetailModels.Paging.Request)
}

final class DetailInteractor: BaseInteractor, DetailDataStore {

  var worker: DetailWorkerLogic?
  var presenter: DetailPresentationLogic?
  
  var photos: [Photo] = []
  var selectedPhotoIndex: Int = 0

}

// MARK: - Business Logic
extension DetailInteractor: DetailBusinessLogic {
  func fetchPhotos(request: DetailModels.Photos.Request) {
    presenter?.presentPhotos(
      response: .init(
        photos: photos,
        selectedPhotoIndex: selectedPhotoIndex
      )
    )
  }
  
  func fetchPaging(request: DetailModels.Paging.Request) {
    selectedPhotoIndex = request.index
    presenter?.presentPaging(
      response: .init(username: photos[request.index].user.name)
    )
  }
}
