//
//  DetailBuilder.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/28.
//

import RIBs

// MARK: - DetailDependency
protocol DetailDependency: Dependency {
  var photoModelsStream: PhotoModelsStream { get }
  var mutablePhotoModelStream: MutablePhotoModelStream { get }
}

// MARK: - DetailComponent
final class DetailComponent: Component<DetailDependency> {
  fileprivate var initialState: DetailPresentableState {
    DetailPresentableState()
  }
  
  var photoModelsStream: PhotoModelsStream {
    dependency.photoModelsStream
  }
  
  var mutablePhotoModelStream: MutablePhotoModelStream {
    dependency.mutablePhotoModelStream
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
      photoModelsStream: component.photoModelsStream,
      mutablePhotoModelStream: component.mutablePhotoModelStream,
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
