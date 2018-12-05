//
//  SignIn+View.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/9/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit
import Swiftea
import Stevia
import ActionKit

extension SignIn {
  class SignInView: UIView, SwifteaView {
    typealias TModel = SignInModel
    typealias TMsg = SignInMsg

    let signInBtn = UIButton()
    let emailField = UITextField()
    let pwdField = UITextField()
    let signUpBtn = UIButton()

//    init() {
//      super.init()
//    }

    func update(dispatch: @escaping Dispatch<SignIn.SignInMsg>, model: SignIn.SignInModel) {
      //todo
    }

    func layout() {
      sv(
        emailField,
        pwdField,
        signInBtn,
        signUpBtn
      )

      signInBtn.setTitle("Sign in", for: .normal) // TODO: resources
    }
  }

}

