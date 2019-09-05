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
  func getMovieDetail(id: String, _ completion: @escaping (Result<DetailModel>) -> Void)

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
  
  func getMovieDetail(id: String, _ completion: @escaping (Result<DetailModel>) -> Void) {
    store.getMovieDetail(id: id) {
      completion($0)
    }
  }
}
