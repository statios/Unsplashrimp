//
//  DetailBuilder.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/28.
//

import RIBs

// MARK: - DetailDependency
protocol DetailDependency: Dependency {
  var photoModelStream: MutablePhotoModelStream { get }
}

// MARK: - DetailComponent
final class DetailComponent: Component<DetailDependency> {
  fileprivate var initialState: DetailPresentableState {
    DetailPresentableState()
  }
  
  var photoModelStream: MutablePhotoModelStream {
    dependency.photoModelStream
  }
}

// MARK: - DetailBuildable
protocol DetailBuildable: Buildable {
  func build(withListener listener: DetailListener) -> DetailRouting
}

// MARK: - DetailBuilder
final class DetailBuilder:
  Builder<DetailDependency>,
  DetailBuildable
{
  
  // MARK: - Con(De)structor
  
  override init(dependency: DetailDependency) {
    super.init(dependency: dependency)
  }
 
  // MARK: - DetailBuildable
  
  func build(withListener listener: DetailListener) -> DetailRouting {
    let component = DetailComponent(dependency: dependency)
    let viewController = DetailViewController()
    let interactor = DetailInteractor(
      initialState: component.initialState,
      photoModelStream: component.photoModelStream,
      presenter: viewController
    )
    interactor.listener = listener
    return DetailRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}

// MARK: - DetailBuildable
extension DetailBuilder {
  
}
