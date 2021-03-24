//
//  SplashRouter.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - SplashInteractable
protocol SplashInteractable: Interactable {
  var router: SplashRouting? { get set }
  var listener: SplashListener? { get set }
}

// MARK: - SplashViewControllable
protocol SplashViewControllable: ViewControllable {
}

// MARK: - SplashRouter
final class SplashRouter:
  ViewableRouter<SplashInteractable, SplashViewControllable>,
  SplashRouting
{
  
  // MARK: - Con(De)structor
  
  override init(
    interactor: SplashInteractable,
    viewController: SplashViewControllable
  ) {
    super.init(
      interactor: interactor,
      viewController: viewController
    )
    interactor.router = self
  }
}

// MARK: - SplashRouting
extension SplashRouter {
}
