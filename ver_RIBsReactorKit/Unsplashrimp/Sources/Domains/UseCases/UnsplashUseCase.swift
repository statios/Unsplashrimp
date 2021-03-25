//
//  UnsplashUseCase.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/25.
//

import Foundation

protocol UnsplashUseCase {
  var repository: UnsplashRepository { get }
}

final class UnsplashUseCaseImpl: UnsplashUseCase {
  let repository: UnsplashRepository
  
  init(repository: UnsplashRepository) {
    self.repository = repository
  }
}
