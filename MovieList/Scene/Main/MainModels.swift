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
  struct Something {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      let result: [MovieModel]
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let content: [DisplayMovie]
      struct DisplayMovie {
        let title: String
        let popularity: Double
        let voteCount: Int
        let voteAverage: Int
        let imageURL: String
      }
    }
  }
}
