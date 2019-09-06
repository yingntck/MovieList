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
      let withUpdateRatingDict: Bool
    }
    /// Data struct sent to Presenter
    struct Response {
      let needUpdateRating: Bool
      let result: Result<[MovieModel]>
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let title: String
      let popularity: String
      let voteCount: Int
      let voteAverage: Double
      let imageURL: String
      let backdropURL: String
    }
  }
  
  struct UpdateRating {
    /// Data struct sent to Interactor
    struct Request {
      let dict: [String: Double]
    }
    /// Data struct sent to Presenter
    struct Response {
      let popularityRes: String
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let popularity: String
    }
  }
}
