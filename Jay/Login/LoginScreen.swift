//
//  Types.swift
//  Jay
//
//  Created by Pavel Shyliahau on 10/15/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Swiftea

enum LoginScreen {
  struct LoginModel: Equatable {
    let username: String
    let password: String

    init(username: String, password: String) {
      self.username = username
      self.password = password
    }

    init() {
      self.init(username: "", password: "")
    }
  }

  enum LoginMsg {
    case onUsernameChanged(String)
    case onPasswordChanged(String)
    case onLoginTapped
  }

  static func mkProgramWith<TView: SwifteaView>(view: TView, model: LoginModel? = nil)->Program<LoginModel, LoginMsg, ()>
    where TView.TModel == LoginModel, TView.TMsg == LoginMsg {
      return Program.mkSimple(
        initModel: { initModel(from: model) },
        update: update,
        view: view.update)
  }

}
