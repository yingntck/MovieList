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
  var movieList: [MovieModel] { get }
}

class MainInteractor: MainInteractorInterface {
  var view: MainViewController!
  var presenter: MainPresenterInterface!
  var worker: MovieWorker?
  var moviePage: MovieList?
  var movieList: [MovieModel] = []
  var currentPage: Int = 1
  var totalPage: Int = 0
  var currentSort: SortData?
  
  // MARK: - Business logic
  func getMovieList(request: Main.GetMovieList.Request) {
    var page = currentPage
    let sort = request.sortType
    if currentSort != sort {
      page = 1
      currentPage = 1
      currentSort = sort
    }

    if request.isLoading {
      //      print("loading")
      worker?.getMovieList(page: page, sort: sort) { [weak self] result in
        var response: Main.GetMovieList.Response
        switch result {
        case .success(let data):
          if let movieList = self?.movieList {
            self?.movieList = movieList + data.results
          }
          guard let result = self?.movieList else { return }
          response = Main.GetMovieList.Response(result: Result<[MovieModel]>.success(result))
          
        case .failure(let error):
          response = Main.GetMovieList.Response(result: Result<[MovieModel]>.failure(error))
        }
        self?.presenter.presentMovieList(response: response)
      }
    } else {
      //      print("feed data normal")
      worker?.getMovieList(page: page, sort: sort) { [weak self] result in
        var response: Main.GetMovieList.Response
        switch result {
        case .success(let data):
          self?.totalPage = data.totalPages
          self?.movieList = data.results
          response = Main.GetMovieList.Response(result: Result<[MovieModel]>.success(data.results))
          
        case .failure(let error):
          response = Main.GetMovieList.Response(result: Result<[MovieModel]>.failure(error))
          print(error)
        }
        self?.presenter.presentMovieList(response: response)
        //          print(response)
      }
    }
    //    print("totalPage: \(totalPage)")
  }
  
  func setCountPage(request: Main.SetLoadMore.Request) {
    let sort = request.sort
    print("page: \(currentPage)")
    currentPage += 1
    if currentPage <= totalPage {
      let request = Main.GetMovieList.Request(isLoading: true, sortType: sort)
      getMovieList(request: request)
    }
  }
  
}
