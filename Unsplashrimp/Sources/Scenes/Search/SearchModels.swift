//
//  SearchModels.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

enum SearchModels {
  
  enum Search {
    struct Request {
      let query: String
    }
    struct Response {
      let search: PaginationResponse<Photo>
    }
    struct ViewModel {
      let photos: [Photo]
    }
  }
  
  enum Pagination {
    struct Request {
    }
    struct Response {
      let search: PaginationResponse<Photo>
    }
    struct ViewModel {
      let photos: [Photo]
    }
  }
}
