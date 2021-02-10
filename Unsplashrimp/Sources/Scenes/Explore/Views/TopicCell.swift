//
//  TopicCell.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/10.
//

import Foundation
import UIKit

class TopicCell: UICollectionViewCell {
  
  @IBOutlet weak var topicLabel: UILabel!
  @IBOutlet weak var selectedMarkView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(_ topic: Topic, isSelected: Bool) {
    topicLabel.text = topic.title
    selectedMarkView.isHidden = !isSelected
  }
  
}
