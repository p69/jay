import Foundation
import Swiftea
import Jay_Domain

extension SignUp {
  static func initModel(with previousModel: Model?)->(Model, Cmd<Msg>) {
    if let prev = previousModel {
      return (prev, [])
    }

    return (Model(email: InputField.valid(""),
                  firstName: InputField.valid(""),
                  lastName: InputField.valid(""),
                  password: InputField.valid(""),
                  retypePassword: InputField.valid(""),
                  inProgress: false,
                  registrationError: nil), [])
  }

  static func update(msg: Msg, model: Model, dependencies: Dependencies) -> (Model, Cmd<Msg>) {
    switch msg {

    case .emailChanged(let value):
      let newModel = model.copyWith(
        email: .some(InputField.valid(value)),
        registrationError: nilArg())
      return (newModel, validateEmailCmd(email: value))

    case .invalidEmail:
      let newModel = model.copyWith(email: .some(InputField.invalid(value: model.email.value, error: "Email must be valid")))
      return (newModel, [])

    case .firstNameChanged(let value):
      let newModel = model.copyWith(
        firstName: .some(InputField.valid(value)),
        registrationError: nilArg())
      return (newModel, [])

    case .lastNameChanged(let value):
      let newModel = model.copyWith(
        lastName: .some(InputField.valid(value)))
      return (newModel, [])

    case .pwdChanged(let value):
      let newModel = model.copyWith(
        password: .some(InputField.valid(value)),
        registrationError: nilArg())
      return (newModel, [])

    case .retypePwdChanged(let value):
      let newModel = model.copyWith(
        retypePassword: .some(InputField.valid(value)),
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
      let newModel = model.copyWith(
        inProgress: .some(false),
        registrationError: .some(error))
      return (newModel, [])
      
    case .createSucceeded(let user):
      //TODO: navigate to home
      let newModel = model.copyWith(
        inProgress: .some(false),
        registrationError: nilArg())
      return (newModel, [])

    default:
      return (model, [])
    }
  }

  struct Dependencies {
    let authContext: AuthContext
    let router: AuthRouter
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
    let result = Auth.createNew(email: email, firstName: firstName, lastName: lastName, pwd: pwd, retypePwd: retypePwd).run(SignIn.context)
    switch result {
    case .ok(let user):
      dispatcher(SignUp.Msg.createSucceeded(user: user))
    case .error(let error):
      dispatcher(SignUp.Msg.createFailed(error: error))
    }
  }
}
