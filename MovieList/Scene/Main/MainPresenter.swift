//
//  MainPresenter.swift
//  MovieList
//
//  Created by Nanthicha Kritveeranant on 2/9/2562 BE.
//  Copyright (c) 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

protocol MainPresenterInterface {
  func presentSomething(response: Main.Something.Response)
}

class MainPresenter: MainPresenterInterface {
  weak var viewController: MainViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: Main.Something.Response) {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller. The resulting view model should be using only primitive types. Eg: the view should not need to involve converting date object into a formatted string. The formatting is done here.

    let viewModel = Main.Something.ViewModel()
    viewController.displaySomething(viewModel: viewModel)
  }
}
