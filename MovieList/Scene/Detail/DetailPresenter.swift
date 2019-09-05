//
//  DetailPresenter.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol DetailPresenterInterface {
  func presentMovieData(response: Detail.GetMovieData.Response)
}

class DetailPresenter: DetailPresenterInterface {
  weak var viewController: DetailViewControllerInterface!


  // MARK: - Presentation logic

  func presentMovieData(response: Detail.GetMovieData.Response) {
    var model: Detail.GetMovieData.ViewModel?
    switch response.movie {
    case .success(let data):
      model = Detail.GetMovieData.ViewModel(title: data.title,
                                                popularity: data.popularity,
                                  imageURL: "https://image.tmdb.org/t/p/original\(data.posterPath)",
                                                category: data.genres.first?.name ?? "",
                                                language: data.originalLanguage)
    case .failure(let error):
      print("error present detail")
      print(error)
    }
    guard let viewModel = model else {
      return
      
    }
    viewController.displayMovieData(viewModel: viewModel)
  }
}
