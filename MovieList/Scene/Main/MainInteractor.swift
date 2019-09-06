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
    if request.withUpdateRatingDict {
      let response = Main.GetMovieList.Response(needUpdateRating: true, result: Result<[MovieModel]>.success(movieList))
      self.presenter.presentMovieList(response: response)
    } else {
      worker?.getMovieList(page: 2, { [weak self] result in
        var response: Main.GetMovieList.Response
        switch result {
        case .success(let data):
          self?.movieList = data.results
          response = Main.GetMovieList.Response(needUpdateRating: false, result: Result<[MovieModel]>.success(data.results))
        case .failure(let error):
          response = Main.GetMovieList.Response(needUpdateRating: false, result: Result<[MovieModel]>.failure(error))
          print(error)
        }
        self?.presenter.presentMovieList(response: response)
  //      print(response)
      })
    }
  }
}
