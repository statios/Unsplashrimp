//
//  ExplorePresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol ExplorePresentationLogic: class {
  
}

final class ExplorePresenter: BasePresenter {
  
  weak var view: ExploreDisplayLogic?

}

// MARK: - Present
extension ExplorePresenter: ExplorePresentationLogic {
  
}
