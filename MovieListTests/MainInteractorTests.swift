//
//  MainInteractorTests.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 12/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

@testable import MovieList
import XCTest

class MainInteractorTests: XCTestCase {
  
  class SpyPresenter: MainPresenterInterface {
    var presentMovieListCalled = false
    func presentMovieList(response: Main.GetMovieList.Response) {
      presentMovieListCalled = true
    }
  }
  
  class SpyWorker: MovieWorker {
    var workerCalled = false
    var isFailure = false
    override func getMovieList(page: Int, sort: SortData, _ completion: @escaping (Result<MovieList>) -> Void) {
      if isFailure {
        completion(Result.failure(NSError(domain: "", code: 0, userInfo: nil)))
      } else {
        completion(Result.success(MovieList(page: 1, totalResults: 10000, totalPages: 500, results: [MovieModel(popularity: 0.6, id: 1, video: false, voteCount: 1, voteAverage: 10.0, title: "Dawn French Live", releaseDate: "2016-12-31", originalLanguage: "en", originalTitle: "Dawn French Live", genreIDS: [], backdropPath: "", adult: false, overview: "Dawn French stars in her acclaimed one-woman show", posterPath: "")])))
      }
    }
  }
  
  
  // MARK: - Subject under test
  
  var sut: MainInteractor!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupMainInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupMainInteractor() {
    sut = MainInteractor()
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  func testGetMovieListCalledSuccess() {
    // Given
    let spyPresenter = SpyPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyWorker(store: MovieRestStore())
    sut.worker = spyWorker
    spyWorker.workerCalled = true
    let request = Main.GetMovieList.Request(needLoadMore: false, sortType: .DESC)
    
    // When
    sut.getMovieList(request: request)
    // Then
    XCTAssertTrue(spyPresenter.presentMovieListCalled)
    XCTAssertEqual(sut.currentSort, .DESC)
    XCTAssertTrue(spyWorker.workerCalled)
  }
  
  func testGetMovieListCalledFailure() {
    // Given
    let spyPresenter = SpyPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyWorker(store: MovieRestStore())
    sut.worker = spyWorker
    spyWorker.isFailure = true
    
    let request = Main.GetMovieList.Request(needLoadMore: false, sortType: .DESC)
    // When
    sut.getMovieList(request: request)
    // Then
    XCTAssertTrue(spyPresenter.presentMovieListCalled)
  }
  
  func testLoadMoreSuccess() {
    // Given
    let spyPresenter = SpyPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyWorker(store: MovieRestStore())
    sut.worker = spyWorker
    
    let request = Main.SetLoadMore.Request()
    sut.currentPage = 1
    sut.totalPage = 500
    // When
    sut.loadmorePage(request: request)
    // Then
    XCTAssertTrue(spyPresenter.presentMovieListCalled)
  }
  
  func testLoadMoreFailure() {
    // Given
    let spyPresenter = SpyPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyWorker(store: MovieRestStore())
    sut.worker = spyWorker
    
    spyWorker.isFailure = true
    
    let request = Main.SetLoadMore.Request()
    sut.currentPage = 1
    sut.totalPage = 500
    // When
    sut.loadmorePage(request: request)
    // Then
    XCTAssertTrue(spyPresenter.presentMovieListCalled)
  }
  
  func testLoadMoreWhenCurrentPageMoreThanTotalPage() {
    // Given
    let spyPresenter = SpyPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyWorker(store: MovieRestStore())
    sut.worker = spyWorker
    
//    spyWorker.isFailure = true
    
    let request = Main.SetLoadMore.Request()
    sut.currentPage = 501
    sut.totalPage = 500
    // When
    sut.loadmorePage(request: request)
    // Then
    
    XCTAssertFalse(spyPresenter.presentMovieListCalled)
  }
  
  func testUpdateVote() {
    // Given
    let spyPresenter = SpyPresenter()
    sut.presenter = spyPresenter
    
    let request = Main.GetMovieList.Request(needLoadMore: false, sortType: .DESC)
    // When
    sut.updateVote(request: request)
    // Then
    XCTAssertTrue(spyPresenter.presentMovieListCalled)
  }
  
}
