//
//  MovieWorker.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 3/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol MovieStoreProtocol {
  func getMovieList(_ completion: @escaping (Result<MovieList>) -> Void)
  func getMovieDetail(_ completion: @escaping (Result<DetailModel>) -> Void)

}

class MovieWorker {
  var store: MovieStoreProtocol

  init(store: MovieStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic
  
  func getMovieList(_ completion: @escaping (Result<MovieList>) -> Void) {
    store.getMovieList {
      completion($0)
    }
  }
  
  func getMovieDetail(_ completion: @escaping (Result<DetailModel>) -> Void) {
    store.getMovieDetail {
      completion($0)
    }
  }

}
