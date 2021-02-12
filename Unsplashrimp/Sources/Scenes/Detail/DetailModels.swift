//
//  DetailModels.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/11.
//

enum DetailModels {
  
  enum Photos {
    struct Request {
      
    }
    struct Response {
      let photos: [Photo]
      let selectedPhotoIndex: Int
    }
    struct ViewModel {
      let photos: [Photo]
      let selectedPhotoIndex: Int
    }
  }
  
  enum Paging {
    struct Request {
      let index: Int
    }
    struct Response {
      let username: String
    }
    struct ViewModel {
      let username: String
    }
  }
}
