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
    let request = Main.GetMovieList.Request(withUpdateRatingDict: false)
    interactor.getMovieList(request: request)
  }
  
  // MARK: - Display logic
  
  func displayMovieList(viewModel: [Main.GetMovieList.ViewModel]) {
//    print(viewModel)
    viewData = viewModel
    tableView.reloadData()
  }
  
  func updatePopularity() {
    // เรียก userdefault เพื่อที่จะ get ค่า id กับ rating มา
    // หา id ที่เท่ากันใน interactor เพื่อที่จะ update ค่า rating
    let request = Main.GetMovieList.Request(withUpdateRatingDict: true)
    interactor.getMovieList(request: request)
  }
  
  func loadmoreData() {
    
  }
  
  // Sorting ASC, DESC
  
//  func showSortAlert() {
//    let alert = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
//
//    alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: { (_) in
//      self.dataInfo.sort(by: { (first, second) -> Bool in
//        first.price<second.price
//      })
//      self.mTableView.reloadData()
//    }))
//
//    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
//
//    }))
//    self.present(alert, animated: true, completion: nil)
//  }
  
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell, let viewData = viewData else {
      return UITableViewCell()
    }
    cell.updateUI(viewData[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
//    print("Selected Row: \(indexPath.row)")
    let id = "\(interactor.movieList[indexPath.row].id)"
    router.navigateToDetail(withID: id)
  }
}
