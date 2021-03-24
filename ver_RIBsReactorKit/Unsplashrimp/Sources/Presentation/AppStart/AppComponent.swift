//
//  AppComponent.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/24.
//

import RIBs

final class AppComponent:
  Component<EmptyDependency>,
  SplashDependency
{
  
  init() {
    super.init(dependency: EmptyComponent())
  }
}
