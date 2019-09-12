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
  func calculateVote(request: Detail.SetVote.Request)
  
  var model: DetailModel? { get }
  var selectedMovie: DetailModel? { get set }
  var id: String? { get set }
  var voteCount: Int? { get set }
  var voteAvg: Double? { get set }
  var newVote: Double? { get set }
  var selectedStar: Int? { get set }
}

class DetailInteractor: DetailInteractorInterface {
  var selectedStar: Int?
  var selectedMovie: DetailModel?
  var voteCount: Int?
  var voteAvg: Double?
  var newVote: Double?
  var id: String?
  var presenter: DetailPresenterInterface!
  var worker: MovieWorker?
  var model: DetailModel?
  
  // MARK: - Business logic
  
  func getMovieData(request: Detail.GetMovieData.Request) {
    guard let movieId = id else {
      return
    }
    worker?.getMovieDetail(id: movieId, { [weak self] result in
      var response: Detail.GetMovieData.Response
      switch result {
      case .success(let data):
        self?.selectedMovie = data
//        print(data)
        response = Detail.GetMovieData.Response(movie: Result<DetailModel>.success(data))
      case .failure(let error):
        response = Detail.GetMovieData.Response(movie: Result<DetailModel>.failure(error))
        print(error)
      }
      self?.presenter.presentMovieData(response: response)
    })
    
  }
  
  func calculateVote(request: Detail.SetVote.Request) {
    guard let id = id else {
      return
    }
    voteCount = selectedMovie?.voteCount
    let count = Double(voteCount ?? 0)
    voteAvg = selectedMovie?.voteAverage
    let avg = voteAvg ?? 0.0
    newVote = ((((avg*count)+(request.voteUser*2))/(count+1))/2)
    selectedStar = Int(request.voteUser)
    
    var voteResult = UserDefaults.standard.object(forKey: "voteByUser") as? [String: Double] ?? [:]
    voteResult[id] = newVote
    UserDefaults.standard.set(voteResult, forKey: "voteByUser")
    
    var lastVote = UserDefaults.standard.object(forKey: "lastVoteByUser") as? [String: Int] ?? [:]
    lastVote[id] = selectedStar
    UserDefaults.standard.set(lastVote, forKey: "lastVoteByUser")
  }
}
