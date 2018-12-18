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

    let scrollView = UIScrollView()
    let contentView = UIView()
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

      emailField.apply(model: model.email, with: emailValidationLabel)
      pwdField.apply(model: model.password)
      retypePwdField.apply(model: model.retypePassword)
      firstNameField.apply(model: model.firstName)
      lastNameField.apply(model: model.lastName)

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
        scrollView.sv(
          contentView.sv(
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
        )
      )

      scrollView.fillContainer()
      contentView.fillContainer()
      contentView.Width == scrollView.Width

      contentView.layout(
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
        20,
        |-20-errorLabel-20-|,
        40,
        createBtn.centerHorizontally().width(>=200) ~ 50
      )
      createBtn.Bottom == contentView.Bottom


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
