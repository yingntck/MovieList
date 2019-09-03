// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieList = try? newJSONDecoder().decode(MovieList.self, from: jsonData)

import Foundation

// MARK: - MovieList
struct MovieList: Codable {
  let page, totalResults, totalPages: Int
  let results: [MovieModel]
  
  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case results
  }
}

// MARK: - Result
struct MovieModel: Codable {
  let popularity: Double
  let id: Int
  let video: Bool
  let voteCount: Int
  let voteAverage: Double
  let title, releaseDate, originalLanguage, originalTitle: String
  let genreIDS: [Int]
  let backdropPath: String?
  let adult: Bool
  let overview: String
  let posterPath: String?
  
  enum CodingKeys: String, CodingKey {
    case popularity, id, video
    case voteCount = "vote_count"
    case voteAverage = "vote_average"
    case title
    case releaseDate = "release_date"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case genreIDS = "genre_ids"
    case backdropPath = "backdrop_path"
    case adult, overview
    case posterPath = "poster_path"
  }
}
