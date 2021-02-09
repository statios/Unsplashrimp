//
//  ExplorePresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExplorePresentationLogic: class {
  func presentTopics(response: ExploreModels.Topics.Response)
  func presentSelectedIndexPath(response: ExploreModels.SelectTopic.Response)
  func presentPhotos(response: ExploreModels.Photos.Response)
}

final class ExplorePresenter: BasePresenter {
  
  weak var view: ExploreDisplayLogic?

}

// MARK: - Present
extension ExplorePresenter: ExplorePresentationLogic {
  func presentTopics(response: ExploreModels.Topics.Response) {
    view?.displayTopics(viewModel: .init(topics: response.topics))
  }
  
  func presentSelectedIndexPath(response: ExploreModels.SelectTopic.Response) {
    view?.displaySelectedTopic(
      viewModel: .init(
        previousSelected: response.previousSelected,
        currentSelected: response.currentSelected
      )
    )
  }
  
  func presentPhotos(response: ExploreModels.Photos.Response) {
    view?.displayPhotos(
      viewModel: .init(
        photos: response.photos,
        newPage: response.newPage,
        index: response.index
      )
    )
  }
}
