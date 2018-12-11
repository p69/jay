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
    return (Model(email: InputField.valid(""), password: InputField.valid(""), inProgress: false, loginError: nil), [])
  }

  static func update(msg: Msg, model: Model, router: AuthRouter) -> (Model, Cmd<Msg>) {
    switch msg {

    case .emailChanged(let value):
      let newModel = model.copyWith(
        email: .some(InputField.valid(value)),
        loginError: OptionalArg<LoginError?>.some(nil))
      return (newModel, validateEmailCmd(email: value))

    case .invalidEmail:
      let newModel = model.copyWith(email: .some(InputField.invalid(value: model.email.value, error: "Email must be valid")))
      return (newModel, [])

    case .pwdChanged(let value):
      let newModel = model.copyWith(
        password: .some(InputField.valid(value)),
        loginError: OptionalArg<LoginError?>.some(nil))
      return (newModel, [])

    case .signInTapped:
      let newModel = model.copyWith(
        inProgress: .some(true),
        loginError: OptionalArg<LoginError?>.some(nil))
      return (newModel, loginCmd(email: model.email.value, pwd: model.password.value))

    case .loginFailed(let error):
      let newModel = model.copyWith(inProgress: .some(false), loginError: .some(error))
      return (newModel, [])

    case .loginSucceeded(_):
      //TODO: navigate
      return (model.copyWith(inProgress: .some(false)), [])

    case .signUpTapped:
      //TODO: navigate
      return (model, Cmd<SignIn.Msg>.of { _ in router.goToSignUp() })

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
      dispatcher(SignIn.Msg.loginFailed(error: error))
    }
  }
}
