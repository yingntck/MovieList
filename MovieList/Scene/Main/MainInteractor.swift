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
  func loadmorePage(request: Main.SetLoadMore.Request)
  func updateVote(request: Main.GetMovieList.Request)
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
    let sort = request.sortType ?? currentSort
    if currentSort != sort {
      page = 1
      currentPage = 1
      currentSort = sort
    } else if currentSort == sort && !request.needLoadMore {
      return
    }
//    print("\(page) \(sort)")
    // needLoadMore
    if request.needLoadMore {
      worker?.getMovieList(page: page, sort: sort ?? .DESC) { [weak self] result in
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
      worker?.getMovieList(page: page, sort: sort ?? .DESC) { [weak self] result in
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
      }
    }
  }
  
  // loadmore
  func loadmorePage(request: Main.SetLoadMore.Request) {
    currentPage += 1
//    print("page: \(currentPage)")
    if currentPage <= totalPage {
      let request = Main.GetMovieList.Request(needLoadMore: true, sortType: nil)
      getMovieList(request: request)
    }
  }
  
  func updateVote(request: Main.GetMovieList.Request) {
    var response: Main.GetMovieList.Response
    response = Main.GetMovieList.Response(result: Result<[MovieModel]>.success(movieList))
    
    presenter.presentMovieList(response: response)
  }
}
