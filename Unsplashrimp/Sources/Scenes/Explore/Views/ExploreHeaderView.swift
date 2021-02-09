//
//  ExploreHeaderView.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/09.
//

import Foundation
import UIKit

final class ExploreHeaderView: UIView {
  let nibName = "ExploreHeaderView"
  var contentView: UIView?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    guard let view = loadViewFromNib() else { return }
    view.frame = self.bounds
    self.addSubview(view)
    contentView = view
  }
  
  func loadViewFromNib() -> UIView? {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as? UIView
  }
}
