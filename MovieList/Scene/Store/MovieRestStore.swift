//
//  MovieResStoreStore.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 3/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import Foundation
import Alamofire

class MovieRestStore: MovieStoreProtocol {
  
  let urlMovie = "http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=release_date.desc&page=1"
  
  let urlDetail = "https://api.themoviedb.org/3/movie/%@?api_key=328c283cd27bd1877d9080ccb1604c91"

  
  func getMovieList(_ completion: @escaping (Result<MovieList>) -> Void) {
    AF.request(URL(string: urlMovie)!, method: .get).responseJSON { response in
      switch response.result {
      case .success:
        do {
//          print("suscess feed movie list")
          let decoder = JSONDecoder()
          let result = try decoder.decode(MovieList.self, from: response.data!)
          completion(.success(result))
        } catch let error {
          print("error case success movie list")
          print(error)
        }
        break
      case let .failure(error):
        print("error case failure movie list")
        print(error)
        break
      }
    }
  }
  
  func getMovieDetail(id: String, _ completion: @escaping (Result<DetailModel>) -> Void) {
    AF.request(URL(string: String(format: urlDetail, id))!, method: .get).responseJSON { (response) in
      switch response.result {
      case .success:
        do {
//          print("suscess feed movie data")
          let decoder = JSONDecoder()
          let result = try decoder.decode(DetailModel.self, from: response.data!)
          completion(.success(result))
        } catch let error {
          print("error case success movie data")
          print(error)
        }
        break
      case let .failure(error):
        print("error case failure movie data")
        print(error)
        break
      }
    }
  }

}
