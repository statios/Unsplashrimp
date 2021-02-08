//
//  SearchPresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SearchPresentationLogic: class {
  
}

final class SearchPresenter: BasePresenter {
  
  weak var view: SearchDisplayLogic?

}

// MARK: - Present
extension SearchPresenter: SearchPresentationLogic {
  
}
