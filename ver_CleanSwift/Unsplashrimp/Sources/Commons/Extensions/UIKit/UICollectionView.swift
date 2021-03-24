//
//  UICollectionView.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/12.
//

import UIKit

extension UICollectionView {
  func dequeueCell<T: UICollectionViewCell>(
    _ cellType: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard let cell = dequeueReusableCell(
      withReuseIdentifier: cellType.className,
      for: indexPath
    ) as? T else { fatalError() }
    return cell
  }
}

