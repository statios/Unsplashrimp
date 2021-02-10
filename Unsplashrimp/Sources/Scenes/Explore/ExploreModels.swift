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
  
  enum Photos {
    struct Request {
    }

    struct Response {
      let photos: [[Photo]]
    }

    struct ViewModel {
      let photos: [[Photo]]
    }
  }
}
