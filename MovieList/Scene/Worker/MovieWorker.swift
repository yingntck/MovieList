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
}

class MovieWorker {
  var store: MovieStoreProtocol

  init(store: MovieStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic
  
  func getMovieList(_ completion: @escaping (Result<MovieList>) -> Void) {
    // NOTE: Do the work
    store.getMovieList {
      // The worker may perform some small business logic before returning the result to the Interactor
      completion($0)
    }
  }
}
