import Foundation
import UIKit
import Swiftea
import Stevia
import ActionKit
import Jay_Domain

extension SignIn {

  fileprivate enum Placeholders: String {
    case email = "example@example.com"
    case password = "your password"
  }

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
      emailField.placeholder = Placeholders.email.rawValue
      pwdField.placeholder = Placeholders.password.rawValue
      signInBtn.setTitle("Sign In", for: .normal)
      signInDescription.text = "Sign In to your account."
      forgotPwdLabel.text = "Forgot passwrd?"
      dontHaveAccountLabel.text = "Don't have an account yet?"
      signUpBtn.setTitle("Sign Up", for: .normal)

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
      label.text = "Incorrect password for \(email)"
    case .notFound(let email):
      label.text = "User \(email) not found"
    case .generic(_):
      label.text = "Error occured"
    }
  }
}
