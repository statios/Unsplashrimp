//
//  MainRouter.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

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
  
  
  // MARK: - Properties
  
  private let exploreBuilder: ExploreBuildable
  private let searchBuilder: SearchBuildable
  
  private var exploreRouter: ExploreRouting?
  private var searchRouter: SearchRouting?
  
  // MARK: - Con(De)structor
  
  init(
    exploreBuilder: ExploreBuilder,
    searchBuilder: SearchBuilder,
    interactor: MainInteractable,
    viewController: MainViewControllable
  ) {
    self.exploreBuilder = exploreBuilder
    self.searchBuilder = searchBuilder
    
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    attatchExploreRIB()
    attatchSearchRIB()
  }
}

// MARK: - MainRouting
extension MainRouter {
  func attatchExploreRIB() {
    let router = exploreBuilder.build(withListener: interactor)
    exploreRouter = router
    attachChild(router)
  }
  
  func attatchSearchRIB() {
    let router = searchBuilder.build(withListener: interactor)
    searchRouter = router
    attachChild(router)
  }
  
  func detatchExploreRIB() {
    // Never Call
  }
  
  func detatchSearchRIB() {
    // Never Call
  }
}
