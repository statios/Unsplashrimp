//
//  SearchCell.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

class SearchCell: UITableViewCell {
  
  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var userLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    photoView.image = nil
    userLabel.text = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configure(_ photo: Photo) {
    photoView.backgroundColor = UIColor(hexString: photo.color)
    photoView.loadImageUsingCache(
      with: photo.urls.regular,
      placeHolder: nil
    )
    userLabel.text = photo.user.name
  }
}

