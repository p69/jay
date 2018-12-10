//
//  SignIn.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/9/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Swiftea
import Jay_Domain

enum SignIn {

  struct Model: Equatable {
    let email: InputField
    let password: InputField
    let inProgress: Bool
  }

  enum Msg {
    case emailChanged(String), pwdChanged(String)
    case signInTapped, signUpTapped
    case invalidEmail
    case loginFailed, loginSucceeded(user: User)
  }
  
  static func mkProgramWith<TView: SwifteaView>(view: TView, model: Model?)->Program<Model, Msg, ()>
    where TView.TModel == Model, TView.TMsg == Msg {
      return Program.mkSimple(
        initModel: { initModel(with: model) },
        update: update,
        view: view.update)
  }

  static let context = AuthContext(repository: RealmUsersRepository())
}

extension SignIn.Model {
  func copyWith(email: InputField? = nil, password: InputField? = nil, inProgress: Bool? = nil) -> SignIn.Model {
    return SignIn.Model(email: email ?? self.email,
                        password: password ?? self.password,
                        inProgress: inProgress ?? self.inProgress)
  }
}
