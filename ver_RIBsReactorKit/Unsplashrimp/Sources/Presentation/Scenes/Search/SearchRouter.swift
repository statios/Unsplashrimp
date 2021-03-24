//
//  SearchRouter.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - SearchInteractable
protocol SearchInteractable: Interactable {
  var router: SearchRouting? { get set }
  var listener: SearchListener? { get set }
}

// MARK: - SearchViewControllable
protocol SearchViewControllable: ViewControllable {
}

// MARK: - SearchRouter
final class SearchRouter:
  ViewableRouter<SearchInteractable, SearchViewControllable>,
  SearchRouting
{
  
  // MARK: - Con(De)structor
  
  override init(
    interactor: SearchInteractable,
    viewController: SearchViewControllable
  ) {
    super.init(
      interactor: interactor,
      viewController: viewController
    )
    interactor.router = self
  }
}

// MARK: - SearchRouting
extension SearchRouter {
}
