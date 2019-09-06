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
  var movieList: [MovieModel] { get }
}

class MainInteractor: MainInteractorInterface {
  
  var presenter: MainPresenterInterface!
  var worker: MovieWorker?
  var model: MovieModel?
  
  var movieList: [MovieModel] = []
  
  // MARK: - Business logic
  func getMovieList(request: Main.GetMovieList.Request) {
    worker?.getMovieList({ [weak self] result in
      var response: Main.GetMovieList.Response
      switch result {
      case .success(let data):
        self?.movieList = data.results
        response = Main.GetMovieList.Response(result: Result<[MovieModel]>.success(data.results))
      case .failure(let error):
        response = Main.GetMovieList.Response(result: Result<[MovieModel]>.failure(error))
        print(error)
      }
      self?.presenter.presentMovieList(response: response)
    })
  }
}
