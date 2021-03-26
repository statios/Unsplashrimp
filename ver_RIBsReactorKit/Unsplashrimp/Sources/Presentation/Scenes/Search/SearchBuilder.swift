//
//  SearchBuilder.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - SearchDependency
protocol SearchDependency: Dependency {
  var searchViewController: SearchPresentable & SearchViewControllable { get }
  var unsplashUseCase: UnsplashUseCase { get }
}

// MARK: - SearchComponent
final class SearchComponent: Component<SearchDependency> {
  fileprivate var initialState: SearchPresentableState {
    SearchPresentableState()
  }
  
  fileprivate var searchViewController: SearchPresentable & SearchViewControllable {
    dependency.searchViewController
  }
  
  fileprivate var unsplashUseCase: UnsplashUseCase {
    dependency.unsplashUseCase
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
    let interactor = SearchInteractor(
      initialState: component.initialState,
      unsplashUseCase: component.unsplashUseCase,
      presenter: component.searchViewController
    )
    interactor.listener = listener
    return SearchRouter(
      interactor: interactor,
      viewController: component.searchViewController
    )
  }
}

// MARK: - SearchBuildable
extension SearchBuilder {
  
}
