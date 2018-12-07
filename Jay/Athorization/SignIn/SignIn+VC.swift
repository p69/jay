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

class SignInViewController: BaseViewController<SignIn.SignInView, SignIn.SignInModel, SignIn.SignInMsg> {
  convenience init() {
    self.init(createView: SignIn.SignInView.init, createProgram: SignIn.mkProgramWith)
  }
}
