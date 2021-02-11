//
//  DetailPresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

protocol DetailPresentationLogic: class {
  func presentPhotos(response: DetailModels.Photos.Response)
}

final class DetailPresenter: BasePresenter {
  
  weak var view: DetailDisplayLogic?

}

// MARK: - Present
extension DetailPresenter: DetailPresentationLogic {
  func presentPhotos(response: DetailModels.Photos.Response) {
    view?.displayPhotos(
      request: .init(
        photos: response.photos,
        selectedPhotoIndex: response.selectedPhotoIndex
      )
    )
  }
}
