//
//  BaseViewController.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

class BaseViewController: UIViewController {
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    Log.verbose(String(describing: Self.self))
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    Log.verbose(String(describing: Self.self))
    build()
  }
  
  deinit {
    Log.verbose(String(describing: Self.self))
  }
  
  @objc dynamic func build() {
    
  }
}
