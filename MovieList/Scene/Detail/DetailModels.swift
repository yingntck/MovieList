//
//  DetailModels.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

struct Detail {
  /// This structure represents a use case
  struct GetMovieData {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      let movie: Result<DetailModel>
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let title: String
      let overview: String
      let popularity: Double
      let imageURL: String
      let category: String
      let language: String
    }
  }
}
