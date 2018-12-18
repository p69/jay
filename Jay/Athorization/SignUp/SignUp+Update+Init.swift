import Foundation
import Swiftea
import Jay_Domain

extension SignUp {
  static func initModel(with previousModel: Model?)->(Model, Cmd<Msg>) {
    if let prev = previousModel {
      return (prev, [])
    }

    return (Model(email: InputFieldModel.valid(""),
                  firstName: InputFieldModel.valid(""),
                  lastName: InputFieldModel.valid(""),
                  password: InputFieldModel.valid(""),
                  retypePassword: InputFieldModel.valid(""),
                  inProgress: false,
                  registrationError: nil), [])
  }

  static func update(msg: Msg, model: Model, dependencies: Dependencies) -> (Model, Cmd<Msg>) {
    switch msg {

    case .emailChanged(let value):
      let newModel = model.copyWith(
        email: .some(InputFieldModel.valid(value)),
        registrationError: nilArg())
      return (newModel, value.isEmpty ? [] : validateEmailCmd(email: value))

    case .invalidEmail:
      let newModel = model.copyWith(email: .some(model.email.setError(with: "Email must be valid")))
      return (newModel, [])

    case .firstNameChanged(let value):
      let newModel = model.copyWith(
        firstName: .some(InputFieldModel.valid(value)),
        registrationError: nilArg())
      return (newModel, [])

    case .lastNameChanged(let value):
      let newModel = model.copyWith(
        lastName: .some(InputFieldModel.valid(value)))
      return (newModel, [])

    case .pwdChanged(let value):
      let newModel = model.copyWith(
        password: .some(InputFieldModel.valid(value)),
        registrationError: nilArg())
      return (newModel, [])

    case .retypePwdChanged(let value):
      let newModel = model.copyWith(
        retypePassword: .some(InputFieldModel.valid(value)),
        registrationError: nilArg())
      return (newModel, [])

    case .createTapped:
      let newModel = model.copyWith(inProgress: .some(true))
      return (newModel, createCmd(email: model.email.value,
                                  firstName: model.firstName.value,
                                  lastName: model.lastName.value,
                                  pwd: model.password.value,
                                  retypePwd: model.retypePassword.value))
    case .createFailed(let error):
      var newModel = updateFieldsState(model: model, error: error)
      newModel = newModel.copyWith(
        inProgress: .some(false),
        registrationError: .some(error))
      return (newModel, [])
      
    case .createSucceeded(let user):
      let newModel = model.copyWith(
        inProgress: .some(false),
        registrationError: nilArg())
      var appSettings = dependencies.settings
      return (newModel, Cmd<Msg>.of {_ in
        appSettings.currentUserEmail.value = user.email
        dependencies.router.goToHome()
      })
    }
  }

  private static func updateFieldsState(model: Model, error: RegistrationError) -> Model {
    switch error {
    case .invalidEmail:
      let email = model.email.setError(with: "Email must be valid")
      return model.copyWith(email: .some(email))
    case .weakPassword(_):
      let password = model.password.setError()
      return model.copyWith(password: .some(password))
    case .alreadyExists:
      let email = model.email.setError()
      return model.copyWith(email: .some(email))
    case .retypePwdError:
      let retype = model.retypePassword.setError()
      return model.copyWith(retypePassword: .some(retype))
    default:
      return model
    }
  }

  struct Dependencies {
    let router: AuthRouter
    let settings: AppSettings
  }
}

fileprivate func validateEmailCmd(email: String) -> Cmd<SignUp.Msg> {
  return Cmd<SignUp.Msg>.of { dispatcher in
    let result = Auth.validateEmail(email)
    if result.isError {
      dispatcher(SignUp.Msg.invalidEmail)
    }
  }
}

fileprivate func createCmd(email: String, firstName: String, lastName: String, pwd: String, retypePwd: String) -> Cmd<SignUp.Msg> {

  return Cmd<SignUp.Msg>.of { dispatcher in
    RealmStore.Users.background { realm in
      let createReader = Auth.createNew(email: email, firstName: firstName, lastName: lastName, pwd: pwd, retypePwd: retypePwd)
      let result = createReader.run(AuthContext(repository: RealmUsersRepository(with: realm)))

      switch result {
      case .ok(let user):
        user.toMain { (user:User) in
          dispatcher(SignUp.Msg.createSucceeded(user: user))
        }
      case .error(let error):
        dispatcher(SignUp.Msg.createFailed(error: error))
      }
    }
  }
}
