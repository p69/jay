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

  var signInView = SignIn.SignInView()
  lazy var signInProgram = SignIn.mkProgramWith(view: signInView)

  override func loadView() {
    signInProgram.run()
    view = signInView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    on("INJECTION_BUNDLE_NOTIFICATION") {
      let updatedView = SignIn.SignInView()
      self.signInView = updatedView
      let newProgram = SignIn.mkProgramWith(view: updatedView, model: self.signInProgram.currentModel)
      self.signInProgram = newProgram
      self.signInProgram.run()
      self.view = updatedView
    }
  }
}

