//
//  ExploreBuilder.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

// MARK: - ExploreDependency
protocol ExploreDependency: ExploreDependencyDetail {
  var exploreViewController: ExplorePresentable & ExploreViewControllable { get }
  var unsplashUseCase: UnsplashUseCase { get }
}

// MARK: - ExploreComponent
final class ExploreComponent: Component<ExploreDependency> {
  fileprivate var initialState: ExplorePresentableState {
    ExplorePresentableState()
  }
  
  fileprivate var exploreViewController: ExplorePresentable & ExploreViewControllable {
    dependency.exploreViewController
  }
  
  fileprivate var unsplashUseCase: UnsplashUseCase {
    dependency.unsplashUseCase
  }
  
  var photoModelsStream: PhotoModelsStream {
    dependency.unsplashUseCase.photoModelsStream
  }
  
  var mutablePhotoModelStream: MutablePhotoModelStream {
    shared { PhotoModelStreamImpl() }
  }
}

// MARK: - ExploreBuildable
protocol ExploreBuildable: Buildable {
  func build(withListener listener: ExploreListener) -> ExploreRouting
}

// MARK: - ExploreBuilder
final class ExploreBuilder:
  Builder<ExploreDependency>,
  ExploreBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: ExploreDependency) {
    super.init(dependency: dependency)
  }
 
  // MARK: - ExploreBuildable
  
  func build(withListener listener: ExploreListener) -> ExploreRouting {
    let component = ExploreComponent(dependency: dependency)
    let interactor = ExploreInteractor(
      initialState: component.initialState,
      unsplashUseCase: component.unsplashUseCase,
      mutablePhotoModelStream: component.mutablePhotoModelStream,
      presenter: component.exploreViewController
    )
    interactor.listener = listener
    return ExploreRouter(
      interactor: interactor,
      viewController: component.exploreViewController
    )
  }
}

// MARK: - ExploreBuildable
extension ExploreBuilder {
  
}
