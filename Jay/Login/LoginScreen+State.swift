//
//  LoginScreen+State.swift
//  Jay
//
//  Created by Pavel Shyliahau on 10/16/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Swiftea

extension LoginScreen {
  static func initModel(from previousModel: LoginModel?)->(LoginModel, Cmd<LoginMsg>) {
    if let prev = previousModel {
      return (prev, [])
    }
    return (LoginModel(), [])
  }
  static func update(msg: LoginMsg, model: LoginModel) throws -> (LoginModel, Cmd<LoginMsg>) {
    switch msg {
    case .onUsernameChanged(let name):
      return (LoginModel(username: name, password: model.password), [])
    case .onPasswordChanged(let pwd):
      return (LoginModel(username: model.username, password: pwd), [])
    case .onLoginTapped:
      //TODO handle
      throw LoginError.loginAttemptError("Login failed")
    }
  }

  enum LoginError : Error {
    case loginAttemptError(String)
    case viewError
  }

}
