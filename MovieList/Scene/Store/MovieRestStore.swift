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
  
  let urlDetail = "https://api.themoviedb.org/3/movie/%@?api_key=328c283cd27bd1877d9080ccb1604c91"
  
  func getMovieList(page: Int, sort: SortData, _ completion: @escaping (Result<MovieList>) -> Void) {
    let sort = sort == .DESC ? "release_date.desc" : "release_date.asc"
    AF.request(URL(string: "http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=\(sort)&page=\(page)")!, method: .get).responseJSON { response in
      switch response.result {
      case .success:
        do {
//          print("suscess feed movie list")
          let decoder = JSONDecoder()
          let result = try decoder.decode(MovieList.self, from: response.data!)
          completion(.success(result))
//          print(result)
        } catch let error {
          print("error case success movie list")
          print(error)
        }
      case let .failure(error):
        print("error case failure movie list")
        print(error)
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
      case let .failure(error):
        print("error case failure movie data")
        print(error)
      }
    }
  }

}
