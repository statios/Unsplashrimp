//
//  PhotosViewModel.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/26.
//

import Foundation
import UIKit

struct PhotoViewModel {
  private let photoModel: PhotoModel
  
  var imageURL: String {
    photoModel.urls.regular
  }
  
  var author: String {
    photoModel.user.name
  }
  
  var id: String {
    photoModel.id
  }
  
  var height: CGFloat {
    CGFloat((photoModel.height / photoModel.height)) * Device.width
  }
  
  var width: CGFloat {
    Device.width
  }
  
  init(photoModel: PhotoModel) {
    self.photoModel = photoModel
  }
}

extension PhotoViewModel: Equatable {
  
}
