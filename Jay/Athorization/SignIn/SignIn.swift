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
    let loginError: LoginError?
  }

  enum Msg {
    case emailChanged(String), pwdChanged(String)
    case signInTapped, signUpTapped
    case invalidEmail
    case loginFailed(error: LoginError), loginSucceeded(user: User)
  }
  
  static func mkProgramWith<TView: SwifteaView>(view: TView, model: Model?, router: AuthRouter)->Program<Model, Msg, ()>
    where TView.TModel == Model, TView.TMsg == Msg {
      return Program.mkSimple(
        initModel: { SignIn.initModel(with: model) },
        update: { msg, model in SignIn.update(msg: msg, model: model, router: router) },
        view: view.update)
  }

  static let context = AuthContext(repository: RealmUsersRepository())
}

extension SignIn.Model {
  func copyWith(email: OptionalArg<InputField> = .none,
                password: OptionalArg<InputField> = .none,
                inProgress: OptionalArg<Bool> = .none,
                loginError: OptionalArg<LoginError?> = .none) -> SignIn.Model {
    return SignIn.Model(email: email.value ?? self.email,
                        password: password.value ?? self.password,
                        inProgress: inProgress.value ?? self.inProgress,
                        loginError: loginError.value ?? self.loginError)
  }
}
