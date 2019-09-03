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
  
  let url = "http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=release_date.desc&page=1"
  
  func getMovieList(_ completion: @escaping (Result<MovieList>) -> Void) {
    AF.request(URL(string: url)!, method: .get).responseJSON { response in
      switch response.result {
      case .success:
        do {
          print("suscess feed")
          let decoder = JSONDecoder()
          let result = try decoder.decode(MovieList.self, from: response.data!)
          completion(.success(result))
        } catch let error {
          print("error case success")
          print(error)
        }
        break
      case let .failure(error):
        print("error case failure")
        print(error)
        break
      }
    }
  }
}
