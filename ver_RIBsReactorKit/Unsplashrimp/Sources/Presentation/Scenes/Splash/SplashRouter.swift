//
//  SplashRouter.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - SplashInteractable
protocol SplashInteractable:
  Interactable,
  MainListener
{
  var router: SplashRouting? { get set }
  var listener: SplashListener? { get set }
}

// MARK: - SplashViewControllable
protocol SplashViewControllable: ViewControllable {
}

// MARK: - SplashRouter
final class SplashRouter:
  LaunchRouter<SplashInteractable, SplashViewControllable>,
  SplashRouting
{
  
  // MARK: - Properties
  
  private let mainBuilder: MainBuildable
  private var mainRouter: MainRouting?
  
  // MARK: - Con(De)structor
  
  init(
    mainBuilder: MainBuildable,
    interactor: SplashInteractable,
    viewController: SplashViewControllable
  ) {
    self.mainBuilder = mainBuilder
    super.init(
      interactor: interactor,
      viewController: viewController
    )
    interactor.router = self
  }
}

// MARK: - SplashRouting
extension SplashRouter {
  func attachMainRIB() {
    let router = mainBuilder.build(withListener: interactor)
    attachChild(router)
    mainRouter = router
    viewController.present(router.viewControllable)
  }
  
  func detachMainRIB() {
    
  }
}
