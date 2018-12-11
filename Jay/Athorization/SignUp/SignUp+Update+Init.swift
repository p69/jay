import Foundation
import Swiftea
import Jay_Domain

extension SignUp {
  static func initModel(with previousModel: Model?)->(Model, Cmd<Msg>) {
    if let prev = previousModel {
      return (prev, [])
    }

    return (Model(email: InputField.valid(""),
                  password: InputField.valid(""),
                  repeatPassword: InputField.valid(""),
                  inProgress: false,
                  registrationError: nil), [])
  }

  static func update(msg: Msg, model: Model, router: AuthRouter) -> (Model, Cmd<Msg>) {
    //TODO

    return (model, [])
  }
}

