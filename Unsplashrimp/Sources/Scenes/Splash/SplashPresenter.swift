//
//  SplashPresenter.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

protocol SplashPresentationLogic: class {
  
}

final class SplashPresenter: BasePresenter {
  
  weak var view: SplashDisplayLogic?

}

// MARK: - Present
extension SplashPresenter: SplashPresentationLogic {
  
}
