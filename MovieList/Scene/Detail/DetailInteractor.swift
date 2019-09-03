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
//    worker?.doSomeWork { [weak self] in
//      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
//        self?.model = data
//      }

      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
//      let response = Detail.Something.Response()
//      self?.presenter.presentSomething(response: response)
//    }
  }
}
