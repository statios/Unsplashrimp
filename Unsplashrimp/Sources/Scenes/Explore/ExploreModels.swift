//
//  ExploreModels.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import UIKit

enum ExploreModels {

  enum Topics {
    struct Request {
    }

    struct Response {
      let topics: [Topic]
    }

    struct ViewModel {
      let topics: [Topic]
    }
  }
  
  enum SelectTopic {
    struct Request {
      let selected: IndexPath
    }

    struct Response {
      let previousSelected: IndexPath?
      let currentSelected: IndexPath
    }

    struct ViewModel {
      let previousSelected: IndexPath?
      let currentSelected: IndexPath
    }
  }
  
  enum Photos {
    struct Request {
      let id: String
      let page: Int
      let index: Int
    }

    struct Response {
      let photos: [Photo]
      let newPage: Int
      let index: Int
    }

    struct ViewModel {
      let photos: [Photo]
      let newPage: Int
      let index: Int
    }
  }
}
