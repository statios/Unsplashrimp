//
//  DetailCell.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

import UIKit

class DetailCell: UICollectionViewCell {
  
  @IBOutlet weak var photoView: UIImageView!
  
  func configure(_ photo: Photo) {
//    photoView.backgroundColor = UIColor(hexString: photo.color)
//    photoView.loadImageUsingCacheWithURLString(
//      photo.urls.regular,
//      placeHolder: nil
//    )
  }
}
