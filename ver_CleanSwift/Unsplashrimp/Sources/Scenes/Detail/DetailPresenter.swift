//
//  DetailPresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

protocol DetailPresentationLogic: class {
  func presentPhotos(response: DetailModels.Photos.Response)
  func presentPaging(response: DetailModels.Paging.Response)
  func presentDismiss(response: DetailModels.Dismiss.Response)
}

final class DetailPresenter: BasePresenter {
  weak var view: DetailDisplayLogic?
}

// MARK:- Present
extension DetailPresenter: DetailPresentationLogic {
  func presentPhotos(response: DetailModels.Photos.Response) {
    view?.displayPhotos(
      viewModel: .init(
        photos: response.photos,
        selectedPhotoIndex: response.selectedPhotoIndex
      )
    )
  }
  
  func presentPaging(response: DetailModels.Paging.Response) {
    view?.displayPaging(viewModel: .init(username: response.username))
  }
  
  func presentDismiss(response: DetailModels.Dismiss.Response) {
    view?.displayDismiss(
      viewModel: .init(selectedPhotoIndex: response.selectedPhotoIndex)
    )
  }
}
