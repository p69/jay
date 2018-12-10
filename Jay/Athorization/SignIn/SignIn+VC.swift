//
//  SignIn+VC.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/6/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit
import Swiftea

class SignInViewController: BaseViewController<SignIn.View, SignIn.Model, SignIn.Msg> {
  convenience init() {
    self.init(createView: SignIn.View.init, createProgram: SignIn.mkProgramWith)
  }
}
