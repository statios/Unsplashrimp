//
//  DetailInteractor.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import Foundation

protocol DetailDataStore: class {

}

protocol DetailBusinessLogic: class {

}

final class DetailInteractor: BaseInteractor, DetailDataStore {

  var worker: DetailWorkerLogic?
  var presenter: DetailPresentationLogic?

}

// MARK: - Business Logic
extension DetailInteractor: DetailBusinessLogic {

}
