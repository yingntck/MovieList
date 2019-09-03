//
//  MovieCell.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var popularityLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  func updateUI(_ displayedMovie: Main.GetMovieList.ViewModel) {
    nameLabel.text = displayedMovie.title
    popularityLabel.text = "\(displayedMovie.popularity)"
    ratingLabel.text = "\(displayedMovie.voteAverage)"
    posterImageView.loadImageUrl(displayedMovie.imageURL)
    backdropImageView.loadImageUrl(displayedMovie.backdropURL)
  }
}
