import Foundation
import UIKit
import Stevia
import ActionKit
import Jay_Domain

extension SignIn {
  final class View: UIView, SwifteaView {
    typealias TModel = Model
    typealias TMsg = Msg

    let scrollView = UIScrollView()
    let contentView = UIView()
    let signInBtn = ButtonWithIcon()
    let emailField = UITextField()
    let pwdField = UITextField()
    let signUpBtn = UIButton()
    let signInDescription = UILabel()
    let forgotPwdLabel = UILabel()
    let dontHaveAccountLabel = UILabel()
    let emailValidationLabel = UILabel()
    let loginErrorLabel = UILabel()

    convenience init() {
      self.init(frame:CGRect.zero)
      layout()
    }

    func update(dispatch: @escaping Dispatch<SignIn.Msg>, model: SignIn.Model) {

      emailField.apply(model: model.email, with: emailValidationLabel)
      pwdField.apply(model: model.password)

      if let loginError = model.loginError {
        loginError.show(in: loginErrorLabel)
      } else {
        loginErrorLabel.text = " "
      }

      signInBtn.isEnabled = !model.inProgress
        && model.email.error == nil
        && !model.password.value.isEmpty

      emailField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.emailChanged(self?.emailField.text ?? ""))
      }

      pwdField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.pwdChanged(self?.pwdField.text ?? ""))
      }

      signInBtn.addControlEvent(.touchDown) {
        dispatch(.signInTapped)
      }

      signUpBtn.addControlEvent(.touchDown) {
        dispatch(.signUpTapped)
      }

    }

    func layout() {
      let bottomItemsStack = [dontHaveAccountLabel, signUpBtn].wrapInHorizontalStack()

      sv(
        scrollView.sv(
          contentView.sv(
          signInDescription,
          emailField,
          pwdField,
          forgotPwdLabel,
          signInBtn,
          bottomItemsStack,
          emailValidationLabel,
          loginErrorLabel
            )
        )
      )
      scrollView.fillContainer()
      contentView.fillContainer()
      contentView.Width == scrollView.Width

      // Vertical + Horizontal Layout
      contentView.layout(
        160,
        signInDescription.centerHorizontally(),
        50,
        |-20-emailField-20-| ~ 50,
        10,
        |-20-emailValidationLabel-20-| ~ 10,
        40,
        |-20-pwdField-20-| ~ 50,
        8,
        align(rights: forgotPwdLabel)-20-|,
        40,
        loginErrorLabel.centerHorizontally(),
        15,
        signInBtn.centerHorizontally().width(>=200) ~ 50,
        50,
        bottomItemsStack.centerHorizontally()
      )
      signUpBtn.Left >= dontHaveAccountLabel.Right + 20
      bottomItemsStack.Bottom == contentView.Bottom

      // Content
      emailField.placeholder = AuthStrings.emailPlaceholder.localized
      pwdField.placeholder = AuthStrings.SignIn.passwordPlaceholder.localized
      signInBtn.setTitle(AuthStrings.SignIn.signInButton.localized, for: .normal)
      signInDescription.text = AuthStrings.SignIn.headerLabel.localized
      forgotPwdLabel.text = AuthStrings.SignIn.forgotPasswordLabel.localized
      dontHaveAccountLabel.text = AuthStrings.SignIn.dontHaveAccountLabel.localized
      signUpBtn.setTitle(AuthStrings.SignIn.signUpButton.localized, for: .normal)

      // Styling
      signInDescription.style(TextStyle.description)
      emailField.style(EditText.loginInput)
      pwdField.style(EditText.loginInput).style(EditText.secure)
      signInBtn.style(ButtonStyle.grey(with: UIImage(named: Assets.Icons.rightArrow.rawValue)!))
      forgotPwdLabel.style(TextStyle.description2)
      dontHaveAccountLabel.style(TextStyle.description2)
      signUpBtn.style(ButtonStyle.linkButton)
      emailValidationLabel.style(TextStyle.validationError)
      loginErrorLabel.style(TextStyle.error)
    }
  }
}


extension LoginError {
  func show(in label:UILabel) {
    switch self {
    case .wrongPassword(let email):
      label.text = AuthStrings.SignIn.wrongPasswordError.localized(email)
    case .notFound(let email):
      label.text = AuthStrings.SignIn.userNotFoundError.localized(email)
    case .generic(_):
      label.text = AuthStrings.SignIn.genericError.localized
    }
  }
}
