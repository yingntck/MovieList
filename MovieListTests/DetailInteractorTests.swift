//
//  DetailInteractorTests.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 13/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

@testable import MovieList
import XCTest

class DetailInteractorTests: XCTestCase {
  
  class SpyDetailPresenter: DetailPresenterInterface {
    
    var presentMovieDataCelled = false
    func presentMovieData(response: Detail.GetMovieData.Response) {
      presentMovieDataCelled = true
    }
  }
  
  class SpyDetailWorker: MovieWorker {
    var isFailure = false
    override func getMovieDetail(id: String, _ completion: @escaping (Result<DetailModel>) -> Void) {
      if isFailure {
        completion(Result.failure(NSError(domain: "", code: 0, userInfo: nil)))
      } else {
        completion(Result<DetailModel>.success(DetailModel(adult: false, backdropPath: "", belongsToCollection: nil, budget: 0, genres: [Genre(id: 1, name: "Comedy")], homepage: "", id: 11, imdbID: "", originalLanguage: "", originalTitle: "Discolocos", overview: "The high energy movement in Mexico", popularity: 2.0, posterPath: "", productionCompanies: nil, productionCountries: nil, releaseDate: "2016-12-31", revenue: 0, runtime: 101, spokenLanguages: [SpokenLanguage(iso639_1: "EN", name: "English")], status: "Released", tagline: "", title: "Discolocos", video: false, voteAverage: 4, voteCount: 1)))
      }
//      (( ((4*1)+(5*2)) /2) /2)
    }
  }
  
  // MARK: - Subject under test
  
  var sut: DetailInteractor!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupDetailInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupDetailInteractor() {
    sut = DetailInteractor()
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  func testDisplayMovieDataSuccess() {
    // Given
    let spyPresenter = SpyDetailPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyDetailWorker(store: MovieRestStore())
    sut.worker = spyWorker
    let request = Detail.GetMovieData.Request()
    sut.id = "\(11)"
    // When
    sut.getMovieData(request: request)
    // Then
    XCTAssertTrue(spyPresenter.presentMovieDataCelled)
  }
  
  func testDisplayMovieDataFailure() {
    // Given
    let spyPresenter = SpyDetailPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyDetailWorker(store: MovieRestStore())
    sut.worker = spyWorker
    let request = Detail.GetMovieData.Request()
    sut.id = "\(11)"
    spyWorker.isFailure = true
    // When
    sut.getMovieData(request: request)
    // Then
    XCTAssertTrue(spyPresenter.presentMovieDataCelled)
  }
  
  func testDisplayMovieDataIdIsNil() {
    // Given
    let spyPresenter = SpyDetailPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyDetailWorker(store: MovieRestStore())
    sut.worker = spyWorker
    let request = Detail.GetMovieData.Request()
    
    sut.id = nil
    // When
    sut.getMovieData(request: request)
    // Then
    XCTAssertFalse(spyPresenter.presentMovieDataCelled)
  }
  
  func testCalculateVoteSuccess() {
    // Given
    let spyPresenter = SpyDetailPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyDetailWorker(store: MovieRestStore())
    sut.worker = spyWorker
    
    sut.selectedMovie = DetailModel(adult: false, backdropPath: "", belongsToCollection: nil, budget: 0, genres: [Genre(id: 1, name: "Comedy")], homepage: "", id: 11, imdbID: "", originalLanguage: "", originalTitle: "Discolocos", overview: "The high energy movement in Mexico", popularity: 2.0, posterPath: "", productionCompanies: nil, productionCountries: nil, releaseDate: "2016-12-31", revenue: 0, runtime: 101, spokenLanguages: [SpokenLanguage(iso639_1: "EN", name: "English")], status: "Released", tagline: "", title: "Discolocos", video: false, voteAverage: 4, voteCount: 1)
    sut.id = "\(String(describing: sut.selectedMovie?.id))"
    let request = Detail.SetVote.Request(voteUser: 5)
    // When
    sut.calculateVote(request: request)
    // Then
    XCTAssertEqual(sut.selectedStar, 5)
    XCTAssertEqual(sut.newVote, 3.5)
  }
  
  func testCalculateVoteIfIdIsNil() {
    // Given
    let spyPresenter = SpyDetailPresenter()
    sut.presenter = spyPresenter
    let spyWorker = SpyDetailWorker(store: MovieRestStore())
    sut.worker = spyWorker
    
    sut.id = nil
    let request = Detail.SetVote.Request(voteUser: 5)
    // When
    sut.calculateVote(request: request)
    //    print(sut.selectedMovie?)
    // Then
    XCTAssertEqual(sut.voteCount, nil)
    XCTAssertEqual(sut.voteAvg, nil)
  }
}
