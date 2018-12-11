import Foundation
import UIKit
import Stevia
import Swiftea
import Jay_Domain

extension SignUp {
  fileprivate enum Placeholders: String {
    case email = "example@example.com"
    case password = "Password"
    case repeatPassword = "Retype password"
    case firstName = "First name"
    case lastName = "Last name"
  }

  final class View: UIView, SwifteaView {
    typealias TModel = Model
    typealias TMsg = Msg

    let createBtn = SimpleHighlightedButton()
    let emailField = UITextField()
    let firstNameField = UITextField()
    let lastNameField = UITextField()
    let pwdField = UITextField()
    let retypePwdField = UITextField()
    let signInDescription = UILabel()
    let emailValidationLabel = UILabel()
    let pwdValidationLabel = UILabel()
    let errorLabel = UILabel()

    convenience init() {
      self.init(frame:CGRect.zero)
      layout()
    }

    func update(dispatch: @escaping Dispatch<SignUp.Msg>, model: SignUp.Model) {

      emailField.apply(inputField: model.email, with: emailValidationLabel)
      pwdField.text = model.password.value
      retypePwdField.text = model.retypePassword.value
      firstNameField.text = model.firstName.value
      lastNameField.text = model.lastName.value

      if let regError = model.registrationError {
        regError.show(in: errorLabel)
      } else {
        errorLabel.text = " "
      }

      createBtn.isEnabled = !model.inProgress
        && model.email.error == nil
        && model.password.error == nil
        && model.retypePassword.error == nil
        && !model.password.value.isEmpty
        && !model.retypePassword.value.isEmpty
        && !model.firstName.value.isEmpty

      emailField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.emailChanged(self?.emailField.text ?? ""))
      }

      firstNameField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.firstNameChanged(self?.firstNameField.text ?? ""))
      }

      lastNameField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.lastNameChanged(self?.lastNameField.text ?? ""))
      }

      pwdField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.pwdChanged(self?.pwdField.text ?? ""))
      }

      retypePwdField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.retypePwdChanged(self?.retypePwdField.text ?? ""))
      }

      createBtn.addControlEvent(.touchDown) {
        dispatch(.createTapped)
      }

    }

    func layout() {
      sv(
        signInDescription,
        emailField,
        firstNameField,
        lastNameField,
        pwdField,
        retypePwdField,
        emailValidationLabel,
        pwdValidationLabel,
        errorLabel,
        createBtn
      )

      layout(
        160,
        signInDescription.centerHorizontally(),
        50,
        |-20-emailField-20-| ~ 50,
        10,
        |-20-emailValidationLabel-| ~ 10,
        20,
        |-20-firstNameField-20-| ~ 50,
        20,
        |-20-lastNameField-20-| ~ 50,
        30,
        |-20-pwdField-20-| ~ 50,
        20,
        |-20-retypePwdField-20-| ~ 50,
        50,
        errorLabel.centerHorizontally(),
        20,
        createBtn.centerHorizontally().width(>=200) ~ 50
      )


      // Content
      emailField.placeholder = Placeholders.email.rawValue
      pwdField.placeholder = Placeholders.password.rawValue
      firstNameField.placeholder = Placeholders.firstName.rawValue
      lastNameField.placeholder = Placeholders.lastName.rawValue
      retypePwdField.placeholder = Placeholders.repeatPassword.rawValue
      createBtn.setTitle("Create", for: .normal)
      signInDescription.text = "Create new account."

      // Styling
      signInDescription.style(TextStyle.description)
      emailField.style(EditText.loginInput)
      firstNameField.style(EditText.loginInput)
      lastNameField.style(EditText.loginInput)
      pwdField.style(EditText.loginInput).style(EditText.secure)
      retypePwdField.style(EditText.loginInput).style(EditText.secure)
      createBtn.style(ButtonStyle.grey)
      emailValidationLabel.style(TextStyle.validationError)
      pwdValidationLabel.style(TextStyle.validationError)
      errorLabel.style(TextStyle.error)
    }
  }
}

extension RegistrationError {
  func show(in label:UILabel) {
    switch self {
    case .alreadyExists:
      label.text = "This email is already in use"
    case .invalidEmail:
      label.text = "Email is invalid"
    case .weakPassword(let hint):
      label.text = hint
    case .retypePwdError:
      label.text = "Passwords don't match"
    case .repositoryError(_):
      label.text = "Something bad has happened. Please try again"
    }
  }
}
