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
      if let voteResult = UserDefaults.standard.object(forKey: "voteByUser") as? [String: Double] {
        print(voteResult)
        
        // remove duplicate code
        viewModel = data.map {
          var voteAvg = $0.voteAverage
          voteAvg = voteAvg/2
          if let vote = voteResult["\($0.id)"] {
            voteAvg = vote
          }
          return Main.GetMovieList.ViewModel(title: $0.title,
                                             popularity: "Popularity: \($0.popularity)",
            rating: voteAvg,
            imageURL: "https://image.tmdb.org/t/p/original\($0.posterPath ?? "" )" ,
            backdropURL: "https://image.tmdb.org/t/p/original\($0.backdropPath ?? "")" )
        }
      } else {
        viewModel = data.map {
          var voteAvg = $0.voteAverage
          voteAvg = voteAvg/2
          return Main.GetMovieList.ViewModel(title: $0.title,
                                             popularity: "Popularity: \($0.popularity)",
            rating: voteAvg,
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
