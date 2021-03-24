//
//  ExploreRouter.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - ExploreInteractable
protocol ExploreInteractable: Interactable {
  var router: ExploreRouting? { get set }
  var listener: ExploreListener? { get set }
}

// MARK: - ExploreViewControllable
protocol ExploreViewControllable: ViewControllable {
}

// MARK: - ExploreRouter
final class ExploreRouter:
  ViewableRouter<ExploreInteractable, ExploreViewControllable>,
  ExploreRouting
{
  
  // MARK: - Con(De)structor
  
  override init(
    interactor: ExploreInteractable,
    viewController: ExploreViewControllable
  ) {
    super.init(
      interactor: interactor,
      viewController: viewController
    )
    interactor.router = self
  }
}

// MARK: - ExploreRouting
extension ExploreRouter {
}
