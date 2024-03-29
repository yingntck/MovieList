//
//  DetailViewController.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol DetailViewControllerInterface: class {
  func displayMovieData(viewModel: Detail.GetMovieData.ViewModel)
}

class DetailViewController: UIViewController, DetailViewControllerInterface {
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var popularityLabel: UILabel!
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet var starButton: [UIButton]!
  
  var interactor: DetailInteractorInterface!
  var router: DetailRouter!
  var viewDetail: Detail.GetMovieData.ViewModel?
  // remove
  var updatePopularity: Detail.SetVote.ViewModel?
  weak var mainViewDelegate: UpdatePopDelegate?

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration

  private func configure(viewController: DetailViewController) {
    let router = DetailRouter()
    router.viewController = viewController

    let presenter = DetailPresenter()
    presenter.viewController = viewController

    let interactor = DetailInteractor()
    interactor.presenter = presenter
    interactor.worker = MovieWorker(store: MovieRestStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    getMovieData()
  }

  // MARK: - Event handling

  func getMovieData() {
    let request = Detail.GetMovieData.Request()
    interactor.getMovieData(request: request)
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    setStar(tag: sender.tag)
    calculateVote(vote: Double(sender.tag))
    mainViewDelegate?.updatePopularity()
  }
  
  func setStar(tag: Int) {
//    print("Rated \(tag) stars.")
    for button in starButton {
      if button.tag > tag {
        button.setBackgroundImage(UIImage.init(named: "star.png"), for: .normal)
      } else {
        button.setBackgroundImage(UIImage.init(named: "star-tap.png"), for: .normal)
      }
    }
  }

  // MARK: - Display logic

  func displayMovieData(viewModel: Detail.GetMovieData.ViewModel) {
    viewDetail = viewModel
    updateDetail(viewDetail!)
  }
  
  func updateDetail(_ viewDetail: Detail.GetMovieData.ViewModel) {
    switch viewDetail.content {
    case .success(let data):
      titleLabel.text = data.title
      overviewLabel.text = data.overview
      popularityLabel.text = data.popularity
      languageLabel.text = data.language
      categoryLabel.text = data.category
      posterImageView.loadImageUrl(data.imageURL)
      setStar(tag: data.vote)
    case .failure(let error):
      print(error)
    }
  }
  
  // User-Defaults Vote
  
  func calculateVote(vote: Double){
    let request = Detail.SetVote.Request(voteUser: vote)
    interactor.calculateVote(request: request)
  }
}
