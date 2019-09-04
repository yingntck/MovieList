//
//  MainViewController.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol MainViewControllerInterface: class {
  func displayMovieList(viewModel: [Main.GetMovieList.ViewModel])
}

class MainViewController: UIViewController, MainViewControllerInterface {
  
  
  var interactor: MainInteractorInterface!
  var router: MainRouter!
  var viewData : [Main.GetMovieList.ViewModel]?

  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: MainViewController) {
    let router = MainRouter()
    router.viewController = viewController

    let presenter = MainPresenter()
    presenter.viewController = viewController

    let interactor = MainInteractor()
    interactor.presenter = presenter
    interactor.worker = MovieWorker(store: MovieRestStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    getMovieList()
  }
  
  // MARK: - Event handling
  
  func getMovieList() {
    // NOTE: Ask the Interactor to do some work
    let request = Main.GetMovieList.Request()
    interactor.getMovieList(request: request)
  }

  // MARK: - Display logic

  func displayMovieList(viewModel: [Main.GetMovieList.ViewModel]) {
    // NOTE: Display the result from the Presenter
    // nameTextField.text = viewModel.name
    print(viewModel)
    viewData = viewModel
    tableView.reloadData()
    }
  
  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToMainViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewData?.count ?? 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell, let viewData = viewData else {
      return UITableViewCell()
    }
    cell.updateUI(viewData[indexPath.row])
    return cell
  }
}
