//
//  MainViewController.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit
import MJRefresh

protocol MainViewControllerInterface: class {
  func displayMovieList(viewModel: [Main.GetMovieList.ViewModel])
}

protocol UpdatePopDelegate: class {
  func updatePopularity()
}

class MainViewController: UIViewController, MainViewControllerInterface, UpdatePopDelegate {
  
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
    setupMovieList()
    getMovieList()
  }
  
  // MARK: - Event handling
  
  func setupMovieList() {
    tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    tableView.mj_footer = MJRefreshAutoNormalFooter()
    tableView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
  }
  
  @IBAction func sortButton(_ sender: Any) {
    showSortingAlert()
  }
  
  func getMovieList() {
    let request = Main.GetMovieList.Request(needLoadMore: false, sortType: .DESC)
    interactor.getMovieList(request: request)
  }

  @objc
  func footerRefresh() {
//    print("Loadmore..")
    let request = Main.SetLoadMore.Request()
    interactor.loadmorePage(request: request)
  }
  
  func pushGetMovieListToInteractor(request: Main.GetMovieList.Request) {
    interactor.getMovieList(request: request)
    tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: false)
  }
  
  func showSortingAlert() {
    let alert = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Old to New (ASC)", style: .default, handler: { [weak self] _ in
      let request = Main.GetMovieList.Request(needLoadMore: false, sortType: .ASC)
      self?.pushGetMovieListToInteractor(request: request)
    }))
    
    alert.addAction(UIAlertAction(title: "New to Old (DESC)", style: .default, handler: { [weak self] _ in
      let request = Main.GetMovieList.Request(needLoadMore: false, sortType: .DESC)
      self?.pushGetMovieListToInteractor(request: request)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
    }))
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Display logic
  
  func displayMovieList(viewModel: [Main.GetMovieList.ViewModel]) {
//    print(viewModel)
    viewData = viewModel
    tableView.mj_footer.endRefreshing()
    tableView.reloadData()
  }
  
  func updatePopularity() {
    // เรียก userdefault เพื่อที่จะ get ค่า id กับ rating มา
    // หา id ที่เท่ากันใน interactor เพื่อที่จะ update ค่า rating
    let request = Main.GetMovieList.Request(needLoadMore: false, sortType: .DESC)
    interactor.updateVote(request: request)
    
  }
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
