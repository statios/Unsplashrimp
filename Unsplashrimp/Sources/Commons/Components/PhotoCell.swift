//
//  PhotoCell.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/09.
//

import UIKit

class PhotoCell: UITableViewCell {
  
  @IBOutlet weak var photoView: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configure(_ photo: Photo) {
    photoView.setImage(photo.urls.regular)
  }
  
}
