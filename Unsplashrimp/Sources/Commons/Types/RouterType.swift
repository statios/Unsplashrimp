//
//  RouterType.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/12.
//

import Foundation
import UIKit

protocol RouterType {
  func pop(
    from target: UIViewController?,
    animated: Bool
  )
  
  func push(
    to: UIViewController,
    from target: UIViewController?,
    animated: Bool
  )
  
  func present(
    to: UIViewController,
    from target: UIViewController?,
    animated: Bool,
    completion: (() -> Void)?
  )
  
  func dismiss(
    from target: UIViewController?,
    animated: Bool,
    completion: (() -> Void)?
  )
}

extension RouterType {
  func pop(
    from target: UIViewController?,
    animated: Bool = true
  ) {
    DispatchQueue.main.async {
      target?.navigationController?.popViewController(animated: animated)
    }
  }
  
  func push(
    to: UIViewController,
    from target: UIViewController?,
    animated: Bool = true
  ) {
    DispatchQueue.main.async {
      target?.navigationController?.pushViewController(to, animated: animated)
    }
  }
  
  func present(
    to: UIViewController,
    from target: UIViewController?,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    DispatchQueue.main.async {
      target?.present(to, animated: animated, completion: completion)
    }
  }
  
  func dismiss(
    from target: UIViewController?,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    DispatchQueue.main.async {
      target?.dismiss(animated: animated, completion: completion)
    }
  }
}
