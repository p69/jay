import Foundation
import Jay_Domain

enum SignIn {

  struct Model: Equatable {
    let email: InputFieldModel
    let password: InputFieldModel
    let inProgress: Bool
    let loginError: LoginError?
  }

  enum Msg {
    case emailChanged(String), pwdChanged(String)
    case signInTapped, signUpTapped
    case invalidEmail
    case loginFailed(error: LoginError), loginSucceeded(user: User)
  }
  
  static func mkProgramWith<TView: SwifteaView>(view: TView, model: Model?, dependencies: Dependencies)->Program<Model, Msg, ()>
    where TView.TModel == Model, TView.TMsg == Msg {
      return Program.mkSimple(
        initModel: { SignIn.initModel(with: model) },
        update: { msg, model in SignIn.update(msg: msg, model: model, dependencies: dependencies) },
        view: view.update)
  }
}

extension SignIn.Model {
  func copyWith(email: OptionalArg<InputFieldModel> = .none,
                password: OptionalArg<InputFieldModel> = .none,
                inProgress: OptionalArg<Bool> = .none,
                loginError: OptionalArg<LoginError?> = .none) -> SignIn.Model {
    return SignIn.Model(email: email.value ?? self.email,
                        password: password.value ?? self.password,
                        inProgress: inProgress.value ?? self.inProgress,
                        loginError: loginError.value ?? self.loginError)
  }
}
