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
  func setCountPage(request: Main.SetLoadMore.Request)
  //  var model: MovieModel? { get }
  var movieList: [MovieModel] { get }
}

class MainInteractor: MainInteractorInterface {
  
  var view: MainViewController!
  var presenter: MainPresenterInterface!
  var worker: MovieWorker?
  //  var model: MovieModel?
  var moviePage: MovieList?
  var movieList: [MovieModel] = []
  var currentPage: Int = 1
  var totalPage: Int = 0
  
  // MARK: - Business logic
  func getMovieList(request: Main.GetMovieList.Request) {
    let page = currentPage
    
    // when give rating in detail scene and update rating in main scene
    if request.withUpdateRatingDict {
      let response = Main.GetMovieList.Response(needUpdateRating: true, result: Result<[MovieModel]>.success(movieList))
      self.presenter.presentMovieList(response: response)
      
    } else if request.isLoading {
      print("loading")
      worker?.getMovieList(page: page, { [weak self] result in
        var response: Main.GetMovieList.Response
        switch result {
        case .success(let data):
          var result: [MovieModel]
          result = self!.movieList + data.results
          response = Main.GetMovieList.Response(needUpdateRating: false, result: Result<[MovieModel]>.success(result))

        case .failure(let error):
          response = Main.GetMovieList.Response(needUpdateRating: false, result: Result<[MovieModel]>.failure(error))
        }
        self?.presenter.presentMovieList(response: response)
      })
    } else {
      print("feed data normal")
      worker?.getMovieList(page: page, { [weak self] result in
        var response: Main.GetMovieList.Response
        
        switch result {
        case .success(let data):
          self?.totalPage = data.totalPages
          self?.movieList = data.results
          response = Main.GetMovieList.Response(needUpdateRating: false, result: Result<[MovieModel]>.success(data.results))
          
        case .failure(let error):
          response = Main.GetMovieList.Response(needUpdateRating: false, result: Result<[MovieModel]>.failure(error))
          print(error)
        }
        self?.presenter.presentMovieList(response: response)
        //          print(response)
      })
    }
//    print("totalPage: \(totalPage)")
  }
  
  func setCountPage(request: Main.SetLoadMore.Request) {
    print("page: \(currentPage)")
    currentPage += 1
    if currentPage <= totalPage {
      let request = Main.GetMovieList.Request(withUpdateRatingDict: false, isLoading: true)
      getMovieList(request: request)
    }
  }
  
}
