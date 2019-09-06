//
//  MainPresenter.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol MainPresenterInterface {
  func presentMovieList(response: Main.GetMovieList.Response)
}

class MainPresenter: MainPresenterInterface {
  
  weak var viewController: MainViewControllerInterface!
  
  // MARK: - Presentation logic
  func presentMovieList(response: Main.GetMovieList.Response) {
    
    var viewModel: [Main.GetMovieList.ViewModel] = []
    switch response.result {
    case .success(let data):
      if response.needUpdateRating {
        guard let voteResult = UserDefaults.standard.object(forKey: "voteByUser") as? [String: Double] else { return }
        print(voteResult)
        viewModel = data.map {
          var voteAvg = $0.voteAverage
          if let vote = voteResult["\($0.id)"] {
            voteAvg = vote
          }
          return Main.GetMovieList.ViewModel(title: $0.title,
                                             popularity: "Popularity: \($0.popularity)",
            voteCount: $0.voteCount,
            voteAverage: voteAvg,
            imageURL: "https://image.tmdb.org/t/p/original\($0.posterPath ?? "" )" ,
            backdropURL: "https://image.tmdb.org/t/p/original\($0.backdropPath ?? "")" )
        }
      } else {
        viewModel = data.map {
          return Main.GetMovieList.ViewModel(title: $0.title,
                                             popularity: "Popularity: \($0.popularity)",
                                             voteCount: $0.voteCount,
                                             voteAverage: $0.voteAverage,
            imageURL: "https://image.tmdb.org/t/p/original\($0.posterPath ?? "" )" ,
            backdropURL: "https://image.tmdb.org/t/p/original\($0.backdropPath ?? "")" )
        }
      }
    case .failure(let error):
      print("error")
      print(error)
    }
    viewController.displayMovieList(viewModel: viewModel)
  }
}
