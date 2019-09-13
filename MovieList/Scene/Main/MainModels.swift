//
//  MainModels.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit
import Alamofire

struct Main {
  /// This structure represents a use case
  struct GetMovieList {
    /// Data struct sent to Interactor
    struct Request {
      let needLoadMore: Bool
      let sortType: SortData?
    }
    /// Data struct sent to Presenter
    struct Response {
      let result: Result<[MovieModel]>
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let title: String
      let popularity: String
      let rating: Double
      let imageURL: String
      let backdropURL: String
    }
  }
  
  struct SetLoadMore {
    /// Data struct sent to Interactor
    struct Request {
    }
    
    /// Data struct sent to Presenter
    struct Response {
      let totalPage: Int
      let currentPage: Int
    }
    
    /// Data struct sent to ViewController
    struct ViewModel {
    }
  }
}
