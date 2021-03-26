//
//  SplashBuilder.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

import RIBs

// MARK: - SplashDependency
protocol SplashDependency: SplashDependencyMain { }

// MARK: - SplashComponent
final class SplashComponent: Component<SplashDependency> {
  
  fileprivate var initialState: SplashPresentableState {
    SplashPresentableState()
  }
  
  let exploreViewController: ExplorePresentable & ExploreViewControllable
  let searchViewController: SearchPresentable & SearchViewControllable
  let mainViewController: MainPresentable & MainViewControllable
  
  init(
    dependency: SplashDependency,
    exploreViewController: ExplorePresentable & ExploreViewControllable,
    searchViewController: SearchPresentable & SearchViewControllable,
    mainViewController: MainPresentable & MainViewControllable
  ) {
    self.exploreViewController = exploreViewController
    self.searchViewController = searchViewController
    self.mainViewController = mainViewController
    super.init(dependency: dependency)
  }
}

// MARK: - SplashBuildable
protocol SplashBuildable: Buildable {
  func build() -> LaunchRouting
}

// MARK: - SplashBuilder
final class SplashBuilder:
  Builder<SplashDependency>,
  SplashBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: SplashDependency) {
    super.init(dependency: dependency)
  }
 
  // MARK: - SplashBuildable
  
  func build() -> LaunchRouting {
    
    let exploreViewController = ExploreViewController()
    let searchViewController = SearchViewController()
    let mainViewController = MainViewController([
      UINavigationController(rootViewController: exploreViewController),
      UINavigationController(rootViewController: searchViewController)
    ])
    
    let component = SplashComponent(
      dependency: dependency,
      exploreViewController: exploreViewController,
      searchViewController: searchViewController,
      mainViewController: mainViewController
    )
    
    let viewController = SplashViewController()
    let interactor = SplashInteractor(
      initialState: component.initialState,
      presenter: viewController
    )
    
    let mainBuilder = MainBuilder(dependency: component)
    
    return SplashRouter(
      mainBuilder: mainBuilder,
      interactor: interactor,
      viewController: viewController
    )
  }
}

// MARK: - SplashBuildable
extension SplashBuilder {
  
}
