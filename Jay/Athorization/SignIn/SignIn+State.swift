//
//  SignIn+State.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/9/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Swiftea
import Jay_Domain

extension SignIn {
  static func initModel(with previousModel: Model?)->(Model, Cmd<Msg>) {
    if let prev = previousModel {
      return (prev, [])
    }
    return (Model(email: InputField.valid(""), password: InputField.valid(""), inProgress: false), [])
  }

  static func update(msg: Msg, model: Model) -> (Model, Cmd<Msg>) {
    switch msg {
    case .emailChanged(let value):
      return (model.copyWith(email: InputField.valid(value)), validateEmailCmd(email: value))
    case .invalidEmail:
      return (model.copyWith(email: InputField.invalid(value: model.email.value, error: "Email must be valid") ), [])
    case .pwdChanged(let value):
      return (model.copyWith(password: InputField.valid(value)), [])
    case .signInTapped:
      return (model.copyWith(inProgress: true), loginCmd(email: model.email.value, pwd: model.password.value))
    default:
      return (model, [])
    }
  }
}

fileprivate func validateEmailCmd(email: String) -> Cmd<SignIn.Msg> {
  return Cmd<SignIn.Msg>.of { dispatcher in
    let result = Auth.validateEmail(email)
    if result.isError {
      dispatcher(SignIn.Msg.invalidEmail)
    }
  }
}

fileprivate func loginCmd(email: String, pwd: String) -> Cmd<SignIn.Msg> {
  return Cmd<SignIn.Msg>.of { dispatcher in
    let result = Auth.tryLogin(email: email, pwd: pwd).run(SignIn.context)
    switch result {
    case .ok(let user):
      dispatcher(SignIn.Msg.loginSucceeded(user: user))
    case .error(let error):
      debugPrint(error)
      dispatcher(SignIn.Msg.loginFailed)
    }
  }
}
