import Foundation
import UIKit
import Stevia
import Swiftea
import Jay_Domain

extension SignUp {
  fileprivate enum Placeholders: String {
    case email = "example@example.com"
    case password = "your password"
    case repeatPassword = "repeat your password"
  }

  final class View: UIView, SwifteaView {
    typealias TModel = Model
    typealias TMsg = Msg

    let createBtn = SimpleHighlightedButton()
    let emailField = UITextField()
    let pwdField = UITextField()
    let repeatPwdField = UITextField()
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

      if let regError = model.registrationError {
        regError.show(in: errorLabel)
      } else {
        errorLabel.text = " "
      }

      createBtn.isEnabled = !model.inProgress
        && model.email.error == nil
        && model.password.error == nil
        && model.repeatPassword.error == nil
        && !model.password.value.isEmpty
        && !model.repeatPassword.value.isEmpty

      emailField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.emailChanged(self?.emailField.text ?? ""))
      }

      pwdField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.pwdChanged(self?.pwdField.text ?? ""))
      }

      repeatPwdField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.repeatPwdChanged(self?.repeatPwdField.text ?? ""))
      }

      createBtn.addControlEvent(.touchDown) {
        dispatch(.createTapped)
      }

    }

    func layout() {
      sv(
        signInDescription,
        emailField,
        pwdField,
        repeatPwdField,
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
        40,
        |-20-pwdField-20-| ~ 50,
        10,
        |-20-pwdValidationLabel-| ~ 10,
        40,
        |-20-repeatPwdField-20-| ~ 50,
        50,
        errorLabel.centerHorizontally(),
        20,
        createBtn.centerHorizontally().width(>=200) ~ 50
      )


      // Content
      emailField.placeholder = Placeholders.email.rawValue
      pwdField.placeholder = Placeholders.password.rawValue
      repeatPwdField.placeholder = Placeholders.repeatPassword.rawValue
      createBtn.setTitle("Create", for: .normal)
      signInDescription.text = "Create new account."

      // Styling
      signInDescription.style(TextStyle.description)
      emailField.style(EditText.loginInput)
      pwdField.style(EditText.loginInput).style(EditText.secure)
      repeatPwdField.style(EditText.loginInput).style(EditText.secure)
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
    case .repositoryError(_):
      label.text = "Something bad has happened. Please try again"
    }
  }
}
