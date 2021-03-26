//
//  ExploreModels.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

enum ExploreModels {
  enum Topics {
    struct Request { }
    struct Response {
      let topics: [Topic]
    }
    struct ViewModel {
      let topics: [Topic]
    }
  }
  
  enum Photos {
    struct Request { }
    struct Response {
      let photos: [[Photo]]
    }
    struct ViewModel {
      let photos: [[Photo]]
    }
  }
  
  enum Pagination {
    struct Request {
      let index: Int
    }
    struct Response {
      let index: Int
      let photos: [Photo]
    }
    struct ViewModel {
      let index: Int
      let photos: [Photo]
    }
  }
  
  enum SelectTopic {
    struct Request {
      let index: Int
    }
    struct Response {
      let index: Int
    }
    struct ViewModel {
      let index: Int
    }
  }
  
  enum SelectPhoto {
    struct Request {
      let index: Int
    }
    struct Response { }
    struct ViewModel { }
  }
  
  enum ErrorMessage {
    struct Response {
      let message: String?
    }
    struct ViewModel {
      let message: String
    }
  }
}
