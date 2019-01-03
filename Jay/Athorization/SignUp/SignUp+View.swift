import Foundation
import UIKit
import Stevia
import Jay_Domain

extension SignUp {
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
      emailField.placeholder = AuthStrings.emailPlaceholder.localized
      pwdField.placeholder = AuthStrings.SignUp.passwordPlaceholder.localized
      firstNameField.placeholder = AuthStrings.SignUp.firstnamePlaceholder.localized
      lastNameField.placeholder = AuthStrings.SignUp.lastnamePlaceholder.localized
      retypePwdField.placeholder = AuthStrings.SignUp.retypePasswordPlaceholder.localized
      createBtn.setTitle(AuthStrings.SignUp.createButton.localized, for: .normal)
      signInDescription.text = AuthStrings.SignUp.heaederLabel.localized

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
      label.text = AuthStrings.SignUp.emailAlreadyUsed.localized
    case .invalidEmail:
      label.text = AuthStrings.emailValidationError.localized
    case .weakPassword(_):
      label.text = AuthStrings.SignUp.passwordErrorHint.localized
    case .retypePwdError:
      label.text = AuthStrings.SignUp.passwordsDontMatchError.localized
    case .repositoryError(_):
      label.text = AuthStrings.SignUp.genericError.localized
    }
  }
}
