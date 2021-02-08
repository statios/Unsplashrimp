//
//  ExploreInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol ExploreDataStore: class {

}

protocol ExploreBusinessLogic: class {

}

final class ExploreInteractor: BaseInteractor, ExploreDataStore {

  var worker: ExploreWorkerLogic?
  var presenter: ExplorePresentationLogic?

}

// MARK: - Business Logic
extension ExploreInteractor: ExploreBusinessLogic {

}
