import Foundation
import Swiftea
import Jay_Domain

enum SignUp {

  struct Model: Equatable {
    let email: InputField
    let firstName: InputField
    let lastName: InputField
    let password: InputField
    let retypePassword: InputField
    let inProgress: Bool
    let registrationError: RegistrationError?
  }

  enum Msg {
    case emailChanged(String), firstNameChanged(String), lastNameChanged(String), pwdChanged(String), retypePwdChanged(String)
    case createTapped
    case invalidEmail
    case createFailed(error: RegistrationError), createSucceeded(user: User)
  }

  static func mkProgramWith<TView: SwifteaView>(view: TView, model: Model?, dependencies: Dependencies)->Program<Model, Msg, ()>
    where TView.TModel == Model, TView.TMsg == Msg {
      return Program.mkSimple(
        initModel: { SignUp.initModel(with: model) },
        update: { msg, model in SignUp.update(msg: msg, model: model, dependencies: dependencies) },
        view: view.update)
  }
}

extension SignUp.Model {
  func copyWith(email: OptionalArg<InputField> = .none,
                firstName: OptionalArg<InputField> = .none,
                lastName: OptionalArg<InputField> = .none,
                password: OptionalArg<InputField> = .none,
                retypePassword: OptionalArg<InputField> = .none,
                inProgress: OptionalArg<Bool> = .none,
                registrationError: OptionalArg<RegistrationError?> = .none) -> SignUp.Model {
    return SignUp.Model(email: email.value ?? self.email,
                        firstName: firstName.value ?? self.firstName,
                        lastName: lastName.value ?? self.lastName,
                        password: password.value ?? self.password,
                        retypePassword: retypePassword.value ?? self.retypePassword,
                        inProgress: inProgress.value ?? self.inProgress,
                        registrationError: registrationError.value ?? self.registrationError)
  }
}
