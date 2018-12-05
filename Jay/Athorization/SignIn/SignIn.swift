//
//  SignIn.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/9/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Swiftea

enum SignIn {

  struct SignInModel: Equatable {
    let email: String
    let password: String
    let inProgress: Bool
  }

  enum SignInMsg {
    case emailChanged(String), pwdChanged(String)
    case signInTapped, signUpTapped
  }
  
  static func mkProgramWith<TView: SwifteaView>(view: TView, model: SignInModel? = nil)->Program<SignInModel, SignInMsg, ()>
    where TView.TModel == SignInModel, TView.TMsg == SignInMsg {
      return Program.mkSimple(
        initModel: { initModel(with: model) },
        update: update,
        view: view.update)
  }

}
