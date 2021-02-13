//
//  UITableViewCell.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/12.
//

import UIKit

extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>(
    _ cellType: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard let cell = self.dequeueReusableCell(
      withIdentifier: cellType.className,
      for: indexPath
    ) as? T else { fatalError() }
    return cell
  }
}
