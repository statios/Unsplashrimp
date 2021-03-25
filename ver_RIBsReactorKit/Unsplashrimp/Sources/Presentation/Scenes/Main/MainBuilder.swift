//
//  MainBuilder.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import UIKit

import RIBs

// MARK: - MainDependency
protocol MainDependency:
  MainDependencyExplore,
  MainDependencySearch
{
  var mainViewController: (MainPresentable & MainViewControllable) { get }
}

// MARK: - MainComponent
final class MainComponent: Component<MainDependency> {
  fileprivate var initialState: MainPresentableState {
    MainPresentableState()
  }
  
  private var unsplashRepository: UnsplashRepository {
    UnsplashRepositoryImpl(service: Networking<UnsplashService>())
  }
  
  var unsplashUseCase: UnsplashUseCase {
    UnsplashUseCaseImpl(repository: unsplashRepository)
  }
}

// MARK: - MainBuildable
protocol MainBuildable: Buildable {
  func build(withListener listener: MainListener) -> MainRouting
}

// MARK: - MainBuilder
final class MainBuilder:
  Builder<MainDependency>,
  MainBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: MainDependency) {
    super.init(dependency: dependency)
  }
 
  // MARK: - MainBuildable
  
  func build(withListener listener: MainListener) -> MainRouting {
    let component = MainComponent(dependency: dependency)
    let viewController = dependency.mainViewController
    let interactor = MainInteractor(
      initialState: component.initialState,
      presenter: viewController
    )
    interactor.listener = listener
    
    let exploreBuilder = ExploreBuilder(dependency: component)
    let searchBuilder = SearchBuilder(dependency: component)
    
    return MainRouter(
      exploreBuilder: exploreBuilder,
      searchBuilder: searchBuilder,
      interactor: interactor,
      viewController: viewController
    )
  }
}

// MARK: - MainBuildable
extension MainBuilder {
  
}
