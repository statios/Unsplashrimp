//
//  SearchBuilder.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - SearchDependency
protocol SearchDependency: Dependency {
}

// MARK: - SearchComponent
final class SearchComponent: Component<SearchDependency> {
  fileprivate var initialState: SearchPresentableState {
    SearchPresentableState()
  }
}

// MARK: - SearchBuildable
protocol SearchBuildable: Buildable {
  func build(withListener listener: SearchListener) -> SearchRouting
}

// MARK: - SearchBuilder
final class SearchBuilder:
  Builder<SearchDependency>,
  SearchBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: SearchDependency) {
    super.init(dependency: dependency)
  }
 
  // MARK: - SearchBuildable
  
  func build(withListener listener: SearchListener) -> SearchRouting {
    let component = SearchComponent(dependency: dependency)
    let viewController = SearchViewController()
    let interactor = SearchInteractor(
      initialState: component.initialState,
      presenter: viewController
    )
    interactor.listener = listener
    return SearchRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}

// MARK: - SearchBuildable
extension SearchBuilder {
  
}
