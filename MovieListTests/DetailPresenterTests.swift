//
//  DetailPresenterTests.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 13/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

@testable import MovieList
import XCTest

class DetailPresenterTests: XCTestCase {
  
  class SpyDetailView: DetailViewControllerInterface {
    var displayMovieDataCalled = false
    func displayMovieData(viewModel: Detail.GetMovieData.ViewModel) {
      displayMovieDataCalled = true
      
    }
    
  }

  // MARK: - Subject under test

  var sut: DetailPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupDetailPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupDetailPresenter() {
    sut = DetailPresenter()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testGetMovieDataSuccess() {
    // Given
    let spyDetailView = SpyDetailView()
    sut.viewController = spyDetailView
    // When
    sut.presentMovieData(response: Detail.GetMovieData.Response(movie: Result<DetailModel>.success(DetailModel(adult: false, backdropPath: "", belongsToCollection: nil, budget: 0, genres: [Genre(id: 1, name: "Comedy")], homepage: "", id: 11, imdbID: "", originalLanguage: "", originalTitle: "Discolocos", overview: "The high energy movement in Mexico", popularity: 2.0, posterPath: "", productionCompanies: nil, productionCountries: nil, releaseDate: "2016-12-31", revenue: 0, runtime: 101, spokenLanguages: [SpokenLanguage(iso639_1: "EN", name: "English")], status: "Released", tagline: "", title: "Discolocos", video: false, voteAverage: 4.5, voteCount: 5))))
    // Then
    XCTAssertTrue(spyDetailView.displayMovieDataCalled)
  }
  
  func testGetMovieDataFailure() {
    // Given
    let spyDetailView = SpyDetailView()
    sut.viewController = spyDetailView
    
    // When
    sut.presentMovieData(response: Detail.GetMovieData.Response(movie: Result<DetailModel>.failure(NSError(domain: "", code: 0, userInfo: nil))))
    // Then
    XCTAssertTrue(spyDetailView.displayMovieDataCalled)
  }
  
  func testGetMovieDataIfCategoryArrayIsNil() {
    // Given
    let spyDetailView = SpyDetailView()
    sut.viewController = spyDetailView
    
    // When
    sut.presentMovieData(response: Detail.GetMovieData.Response(movie: Result<DetailModel>.success(DetailModel(adult: false, backdropPath: "", belongsToCollection: nil, budget: 0, genres: [], homepage: "", id: 11, imdbID: "", originalLanguage: "", originalTitle: "Discolocos", overview: "The high energy movement in Mexico", popularity: 2.0, posterPath: "", productionCompanies: nil, productionCountries: nil, releaseDate: "2016-12-31", revenue: 0, runtime: 101, spokenLanguages: [SpokenLanguage(iso639_1: "EN", name: "English")], status: "Released", tagline: "", title: "Discolocos", video: false, voteAverage: 4.5, voteCount: 5))))
    // Then
    XCTAssertTrue(spyDetailView.displayMovieDataCalled)
  }
  
}
