//
//  MainRouter.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol MainRouterInput {
  func navigateToDetail(withID: String)
}

class MainRouter: MainRouterInput {
  weak var viewController: MainViewController!

  // MARK: - Navigation

  func navigateToDetail(withID: String) {
    if let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController {
      detailViewController.interactor.id = withID
      viewController.navigationController?.pushViewController(detailViewController, animated: true)
      print(withID)
    }
  }

  // MARK: - Communication

  func passDataToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.interactor.model = viewController.interactor.model
  }
}
