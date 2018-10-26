//
//  ViewController.swift
//  Jay
//
//  Created by Pavel Shyliahau on 10/6/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import UIKit
import Stevia
import Swiftea

class ViewController: UIViewController {

  var loginView = LoginScreen.LoginView()
  lazy var loginProgram = LoginScreen.mkProgramWith(view: loginView)

  override func loadView() {
    loginProgram.run()
    view = loginView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    on("INJECTION_BUNDLE_NOTIFICATION") {
      let updatedView = LoginScreen.LoginView()
      self.loginView = updatedView
      let newProgram = LoginScreen.mkProgramWith(view: updatedView, model: self.loginProgram.currentModel)
      self.loginProgram = newProgram
      self.loginProgram.run()
      self.view = updatedView
    }
  }
}

