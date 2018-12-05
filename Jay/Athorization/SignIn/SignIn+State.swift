//
//  SignIn+State.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/9/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Swiftea

extension SignIn {
  static func initModel(with previousModel: SignInModel?)->(SignInModel, Cmd<SignInMsg>) {
    if let prev = previousModel {
      return (prev, [])
    }
    return (SignInModel(email: "", password: "", inProgress: false), [])
  }

  static func update(msg: SignInMsg, model: SignInModel) -> (SignInModel, Cmd<SignInMsg>) {
    //todo
    return (model, [])
  }
}
