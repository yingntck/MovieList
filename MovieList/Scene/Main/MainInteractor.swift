//
//  MainInteractor.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol MainInteractorInterface {
  func getMovieList (request: Main.GetMovieList.Request)
  var model: MovieModel? { get }
}

class MainInteractor: MainInteractorInterface {
  
  var presenter: MainPresenterInterface!
  var worker: MovieWorker?
  var model: MovieModel?
  
  var movieList: [MovieList] = []
  
  // MARK: - Business logic
  func getMovieList(request: Main.GetMovieList.Request) {
    worker?.getMovieList({ [weak self] result in
      var response: Main.GetMovieList.Response?
      switch result {
      case .success(let data):
        response = Main.GetMovieList.Response(result: Result<[MovieModel]>.success(data.results))
      case .failure(let error):
        print(error)
      }
      guard let respons = response else {
        return
      }
      self?.presenter.presentMovieList(response: respons)
    })
  }
}

// NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
//      let response = Main.Something.Response()
//      self?.presenter.presentSomething(response: response)
//    }
//  }
//}
