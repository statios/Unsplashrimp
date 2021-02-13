//
//  ExplorePresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExplorePresentationLogic: class {
  func presentTopics(response: ExploreModels.Topics.Response)
  func presentPhotos(response: ExploreModels.Photos.Response)
  func presentPagination(response: ExploreModels.Pagination.Response)
  func presentSelectTopic(resposne: ExploreModels.SelectTopic.Response)
  func presentSelectPhoto(resposne: ExploreModels.SelectPhoto.Response)
  func presentErrorMessage(resposne: ExploreModels.ErrorMessage.Response)
}

final class ExplorePresenter: BasePresenter {
  
  weak var view: ExploreDisplayLogic?

}

// MARK: - Present
extension ExplorePresenter: ExplorePresentationLogic {
  func presentTopics(response: ExploreModels.Topics.Response) {
    view?.displayTopics(viewModel: .init(topics: response.topics))
  }
  
  func presentPhotos(response: ExploreModels.Photos.Response) {
    view?.displayPhotos(viewModel: .init(photos: response.photos))
  }
  
  func presentPagination(response: ExploreModels.Pagination.Response) {
    view?.displayPagination(
      viewModel: .init(index: response.index, photos: response.photos)
    )
  }
  
  func presentSelectTopic(resposne: ExploreModels.SelectTopic.Response) {
    view?.displaySelectTopic(viewModel: .init(index: resposne.index))
  }
  
  func presentSelectPhoto(resposne: ExploreModels.SelectPhoto.Response) {
    view?.displaySelectPhoto(viewModel: .init())
  }
  
  func presentErrorMessage(resposne: ExploreModels.ErrorMessage.Response) {
    guard let message = resposne.message else { return }
    view?.displayErrorMessage(viewModel: .init(message: message))
  }
}
