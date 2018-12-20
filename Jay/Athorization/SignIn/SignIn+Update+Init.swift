import Foundation
import Swiftea
import Jay_Domain
import RealmSwift

extension SignIn {
  static func initModel(with previousModel: Model?)->(Model, Cmd<Msg>) {
    if let prev = previousModel {
      return (prev, [])
    }
    return (Model(email: InputFieldModel.valid(""), password: InputFieldModel.valid(""), inProgress: false, loginError: nil), [])
  }

  static func update(msg: Msg, model: Model, dependencies: Dependencies) -> (Model, Cmd<Msg>) {
    switch msg {

    case .emailChanged(let value):
      let newModel = model.copyWith(
        email: .some(InputFieldModel.valid(value)),
        loginError: nilArg())
      return (newModel, value.isEmpty ? [] : validateEmailCmd(email: value))

    case .invalidEmail:
      let newModel = model.copyWith(email:
        .some(InputFieldModel.invalid(value: model.email.value,
                                      error: AuthStrings.emailValidationError.localized)))
      return (newModel, [])

    case .pwdChanged(let value):
      let newModel = model.copyWith(
        password: .some(InputFieldModel.valid(value)),
        loginError: nilArg())
      return (newModel, [])

    case .signInTapped:
      let newModel = model.copyWith(
        inProgress: .some(true),
        loginError: nilArg())
      return (newModel, loginCmd(email: model.email.value, pwd: model.password.value))

    case .loginFailed(let error):
      let newModel = model.copyWith(
        password: tryUpdatePwdField(model, error),
        inProgress: .some(false),
        loginError: .some(error))
      return (newModel, [])

    case .loginSucceeded(let user):
      debugPrint("Logged in as: ", user)
      var settings = dependencies.settings
      return (model.copyWith(inProgress: .some(false)), Cmd<SignIn.Msg>.of { _ in
        settings.currentUserEmail.value = user.email
        dependencies.router.goToHome()
      })

    case .signUpTapped:
      return (model, Cmd<SignIn.Msg>.of { _ in dependencies.router.goToSignUp() })
    }
  }

  private static func tryUpdatePwdField(_ model: Model,_ error: LoginError) -> OptionalArg<InputFieldModel> {
    switch error {
    case .wrongPassword(_):
      return .some(model.password.setError())
    default:
      return .none
    }
  }

  struct Dependencies {
    let router: AuthRouter
    let settings: AppSettings
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
    RealmStore.Users.background { realm in
      let loginReader = Auth.tryLogin(email: email, pwd: pwd)
      let context = AuthContext(repository: RealmUsersRepository(with: realm))
      let result = loginReader.run(context)

      switch result {
      case .ok(let user):
        user.toMain { (user: User) in
          dispatcher(SignIn.Msg.loginSucceeded(user: user))
        }
      case .error(let error):
        dispatcher(SignIn.Msg.loginFailed(error: error))
      }
    }

  }
}
