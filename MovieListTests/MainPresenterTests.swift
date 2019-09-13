//
//  MainPresenterTests.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 12/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

@testable import MovieList
import XCTest

class MainPresenterTests: XCTestCase {
  
  class SpyMainView: MainViewControllerInterface {
    var displayMovieListCalled = false
    var data:[Main.GetMovieList.ViewModel] = [] // capture data
    func displayMovieList(viewModel: [Main.GetMovieList.ViewModel]) {
//      data = viewModel
      displayMovieListCalled = true
    }
  }

  // MARK: - Subject under test

  var sut: MainPresenter!
  
  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMainPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMainPresenter() {
    sut = MainPresenter()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testDisplayMovieListCallSuccess() {
    // Given
    let spy = SpyMainView()
    sut.viewController = spy
    // When
    sut.presentMovieList(response: Main.GetMovieList.Response(result: .success([MovieModel(popularity: 0.6, id: 1, video: false, voteCount: 1, voteAverage: 10.0, title: "Dawn French Live", releaseDate: "2016-12-31", originalLanguage: "en", originalTitle: "Dawn French Live", genreIDS: [], backdropPath: "", adult: false, overview: "Dawn French stars in her acclaimed one-woman show", posterPath: "")])))
    // Then
    XCTAssertTrue(spy.displayMovieListCalled)
//    print(spy.displayMovieListCalled)
    print("data: \(spy.data)")
//    XCTAssert(spy.data.isEmpty)
//    let data = 5
//    XCTAssertEqual(data, 5, "Data must be 5")
  }
  
  func testDisplayMovieListCallFailure() {
    // Given
    let spy = SpyMainView()
    sut.viewController = spy
    // When
    sut.presentMovieList(response: Main.GetMovieList.Response(result: .failure(NSError(domain: "", code: 0, userInfo: nil))))
    // Then
    XCTAssert(spy.displayMovieListCalled)
  }
  
//  func testData() {
//    // Given
//    let spy = Spy()
//    sut.viewController = spy
//    let model1:MovieModel = MovieModel(popularity: 0.0, id: 1, video: false, voteCount: 1, voteAverage: 1, title: "Oat", releaseDate: "", originalLanguage: "", originalTitle: "", genreIDS: [], backdropPath: "", adult: false, overview: "", posterPath: "")
//    let model2:MovieModel = MovieModel(popularity: 1.0, id: 2, video: false, voteCount: 2, voteAverage: 2, title: "Nick", releaseDate: "", originalLanguage: "", originalTitle: "", genreIDS: [], backdropPath: "", adult: false, overview: "", posterPath: "")
//    let model3:MovieModel = MovieModel(popularity: 1.0, id: 3, video: false, voteCount: 2, voteAverage: 2, title: "Ying", releaseDate: "", originalLanguage: "", originalTitle: "", genreIDS: [], backdropPath: "", adult: false, overview: "", posterPath: "")
//    let dataArray:[MovieModel] = [model1, model2, model3]
    // When
//    let result = Result<[MovieModel]>.success(dataArray)
//    let data = Main.GetMovieList.Response(result: result)
//    sut.presentMovieList(response: data)
  
//    sut.presentMovieList(response: Main.GetMovieList.Response(result: Result<[MovieModel]>.success(dataArray)))
  
//    sut.presentMovieList(response: Main.GetMovieList.Response(result: Result<[MovieModel]>.success([MovieModel(popularity: 1.0, id: 1, video: false, voteCount: 1, voteAverage: 1, title: "Oat", releaseDate: "", originalLanguage: "", originalTitle: "", genreIDS: [], backdropPath: "", adult: false, overview: "", posterPath: "")])))
//
////     Then
//    print(spy.data[1])
//    XCTAssertEqual(spy.data[1].popularity, "Popularity: 1.0")
//  }
}
