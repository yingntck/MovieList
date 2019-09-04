//
//  DetailInteractor.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol DetailInteractorInterface {
  func getMovieData(request: Detail.GetMovieData.Request)
  var model: DetailModel? { get }
}

class DetailInteractor: DetailInteractorInterface {
  var presenter: DetailPresenterInterface!
  var worker: MovieWorker?
  var model: DetailModel?

  // MARK: - Business logic

  func getMovieData(request: Detail.GetMovieData.Request) {
    worker?.getMovieDetail({ [weak self] result in
    var response: Detail.GetMovieData.Response
    switch result {
    case .success(let data):
      print(data)
      response = Detail.GetMovieData.Response(movie: data)
    case .failure(let error):
      response = Detail.GetMovieData.Response(movie: error as! DetailModel)
      print(error)
    }
    self?.presenter.presentMovieData(response: response)
  })

  }
}
