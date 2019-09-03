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
  
  var interactor: DetailInteractorInterface!
  var router: DetailRouter!

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
    // NOTE: Ask the Interactor to do some work

    let request = Detail.GetMovieData.Request()
    interactor.getMovieData(request: request)
  }

  // MARK: - Display logic

  func displayMovieData(viewModel: Detail.GetMovieData.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToDetailViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
