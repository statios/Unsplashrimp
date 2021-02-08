//
//  SplashInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol SplashDataStore: class {

}

protocol SplashBusinessLogic: class {

}

final class SplashInteractor: BaseInteractor, SplashDataStore {

  var worker: SplashWorkerLogic?
  var presenter: SplashPresentationLogic?

}

// MARK: - Business Logic
extension SplashInteractor: SplashBusinessLogic {

}
