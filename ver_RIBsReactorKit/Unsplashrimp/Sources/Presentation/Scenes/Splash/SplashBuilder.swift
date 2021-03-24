//
//  SplashBuilder.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - SplashDependency
protocol SplashDependency: Dependency {
}

// MARK: - SplashComponent
final class SplashComponent: Component<SplashDependency> {
  fileprivate var initialState: SplashPresentableState {
    SplashPresentableState()
  }
}

// MARK: - SplashBuildable
protocol SplashBuildable: Buildable {
  func build(withListener listener: SplashListener) -> SplashRouting
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
  
  func build(withListener listener: SplashListener) -> SplashRouting {
    let component = SplashComponent(dependency: dependency)
    let viewController = SplashViewController()
    let interactor = SplashInteractor(
      initialState: component.initialState,
      presenter: viewController
    )
    interactor.listener = listener
    return SplashRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}

// MARK: - SplashBuildable
extension SplashBuilder {
  
}
