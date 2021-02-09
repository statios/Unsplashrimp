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
  
  override var isSelected: Bool {
    didSet {
      updateSelectedMark()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(_ topic: Topic) {
    topicLabel.text = topic.title
    updateSelectedMark()
  }
  
  func updateSelectedMark() {
    selectedMarkView.isHidden = !isSelected
  }
  
}
