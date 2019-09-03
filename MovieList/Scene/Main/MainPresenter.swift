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
      viewModel = data.map {
        return Main.GetMovieList.ViewModel(title: $0.title, popularity: $0.popularity, voteCount: $0.voteCount, voteAverage: $0.voteAverage, imageURL: $0.posterPath ?? "", backdropURL: $0.backdropPath ?? "")
      }
      //      for a in data{
      //        viewModel?.append(Main.GetMovieList.ViewModel(title: a., popularity: <#T##Double#>, voteCount: <#T##Int#>, voteAverage: <#T##Int#>, imageURL: <#T##String#>))
      //      }
      
    case .failure(let error):
      print("error")
      print(error)
    }
    viewController.displayMovieList(viewModel: viewModel)
  }
}
