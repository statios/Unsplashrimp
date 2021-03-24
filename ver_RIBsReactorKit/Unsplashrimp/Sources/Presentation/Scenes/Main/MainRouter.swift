//
//  MainRouter.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - MainInteractable
protocol MainInteractable:
  Interactable,
  ExploreListener,
  SearchListener
{
  var router: MainRouting? { get set }
  var listener: MainListener? { get set }
}

// MARK: - MainViewControllable
protocol MainViewControllable: ViewControllable {
}

// MARK: - MainRouter
final class MainRouter:
  ViewableRouter<MainInteractable, MainViewControllable>,
  MainRouting
{
  
  // MARK: - Con(De)structor
  
  override init(
    interactor: MainInteractable,
    viewController: MainViewControllable
  ) {
    super.init(
      interactor: interactor,
      viewController: viewController
    )
    interactor.router = self
  }
}

// MARK: - MainRouting
extension MainRouter {
}
