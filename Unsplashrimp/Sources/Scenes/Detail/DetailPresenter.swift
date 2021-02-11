//
//  DetailPresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

protocol DetailPresentationLogic: class {
  
}

final class DetailPresenter: BasePresenter {
  
  weak var view: DetailDisplayLogic?

}

// MARK: - Present
extension DetailPresenter: DetailPresentationLogic {
  
}
