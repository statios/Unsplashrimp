//
//  DetailRouter.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/28.
//

import RIBs

// MARK: - DetailInteractable
protocol DetailInteractable: Interactable {
  var router: DetailRouting? { get set }
  var listener: DetailListener? { get set }
}

// MARK: - DetailViewControllable
protocol DetailViewControllable: ViewControllable {
}

// MARK: - DetailRouter
final class DetailRouter:
  ViewableRouter<DetailInteractable, DetailViewControllable>,
  DetailRouting
{
  
  // MARK: - Con(De)structor
  
  override init(
    interactor: DetailInteractable,
    viewController: DetailViewControllable
  ) {
    super.init(
      interactor: interactor,
      viewController: viewController
    )
    interactor.router = self
  }
}

// MARK: - DetailRouting
extension DetailRouter {
}
