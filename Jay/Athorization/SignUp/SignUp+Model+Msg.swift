import Foundation
import Swiftea
import Jay_Domain

enum SignUp {

  struct Model: Equatable {
    let email: InputField
    let password: InputField
    let repeatPassword: InputField
    let inProgress: Bool
    let registrationError: RegistrationError?
  }

  enum Msg {
    case emailChanged(String), pwdChanged(String), repeatPwdChanged(String)
    case createTapped
    case invalidEmail, weakPassword(hint: String)
    case createFailed(error: RegistrationError), createSucceeded(user: User)
  }

  static func mkProgramWith<TView: SwifteaView>(view: TView, model: Model?, router: AuthRouter)->Program<Model, Msg, ()>
    where TView.TModel == Model, TView.TMsg == Msg {
      return Program.mkSimple(
        initModel: { SignUp.initModel(with: model) },
        update: { msg, model in SignUp.update(msg: msg, model: model, router: router) },
        view: view.update)
  }
}

extension SignUp.Model {
  func copyWith(email: OptionalArg<InputField> = .none,
                password: OptionalArg<InputField> = .none,
                repeatPassword: OptionalArg<InputField> = .none,
                inProgress: OptionalArg<Bool> = .none,
                registrationError: OptionalArg<RegistrationError?> = .none) -> SignUp.Model {
    return SignUp.Model(email: email.value ?? self.email,
                        password: password.value ?? self.password,
                        repeatPassword: repeatPassword.value ?? self.repeatPassword,
                        inProgress: inProgress.value ?? self.inProgress,
                        registrationError: registrationError.value ?? self.registrationError)
  }
}
