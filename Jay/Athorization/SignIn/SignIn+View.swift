//
//  SignIn+View.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/9/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit
import Swiftea
import Stevia
import ActionKit

extension SignIn {

  fileprivate enum Placeholders: String {
    case email = "example@example.com"
    case password = "your password"
  }

  final class View: UIView, SwifteaView {
    typealias TModel = Model
    typealias TMsg = Msg

    let signInBtn = ButtonWithIcon()
    let emailField = UITextField()
    let pwdField = UITextField()
    let signUpBtn = UILabel()
    let signInLabel = UILabel()
    let signInDescription = UILabel()
    let forgotPwdLabel = UILabel()
    let dontHaveAccountLabel = UILabel()
    let emailValidationLabel = UILabel()
    let pwdValidationLabel = UILabel()

    convenience init() {
      self.init(frame:CGRect.zero)
      layout()
    }

    func update(dispatch: @escaping Dispatch<SignIn.Msg>, model: SignIn.Model) {

      emailField.apply(inputField: model.email, with: emailValidationLabel)
      pwdField.apply(inputField: model.password, with: pwdValidationLabel)
      signInBtn.isEnabled = model.email.error == nil && !model.password.value.isEmpty

      emailField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.emailChanged(self?.emailField.text ?? ""))
      }

      pwdField.addControlEvent(.editingChanged) { [weak self] in
        dispatch(.pwdChanged(self?.pwdField.text ?? ""))
      }

      signInBtn.addControlEvent(.touchDown) {
        dispatch(.signInTapped)
      }

    }

    func layout() {
      let bottomItemsStack = [dontHaveAccountLabel, signUpBtn].wrapInHorizontalStack()

      sv(
        signInLabel,
        signInDescription,
        emailField,
        pwdField,
        forgotPwdLabel,
        signInBtn,
        bottomItemsStack,
        emailValidationLabel,
        pwdValidationLabel
      )

      // Vertical + Horizontal Layout in one pass
      // With type-safe visual format
      layout(
        80,
        signInLabel.centerHorizontally(),
        80,
        signInDescription.centerHorizontally(),
        50,
        |-20-emailField-20-| ~ 50,
        10,
        |-20-emailValidationLabel-| ~ 10,
        40,
        |-20-pwdField-20-| ~ 50,
        10,
        |-20-pwdValidationLabel-| ~ 10,
        8,
        align(rights: forgotPwdLabel)-20-|,
        60,
        signInBtn.centerHorizontally().width(>=200) ~ 50,
        50,
        bottomItemsStack.centerHorizontally()

      )
      signUpBtn.Left >= dontHaveAccountLabel.Right + 20.0


      emailField.placeholder = Placeholders.email.rawValue
      pwdField.placeholder = Placeholders.password.rawValue

      // Styling 🎨

      emailField.style(commonFieldStyle)
      pwdField.style(commonFieldStyle).style { f in
        f.isSecureTextEntry = true
        f.returnKeyType = .done
      }
      signInBtn.style(signInBtnStyle)
      signInLabel.style(headerStyle)
      forgotPwdLabel.style(description2Style)
      dontHaveAccountLabel.style(description2Style)
      signUpBtn.style(linkBtnStyle)
      emailValidationLabel.style(validationLabelStyle)
      pwdValidationLabel.style(validationLabelStyle)

      // Content 🖋
      signInBtn.setTitle("Sign In", for: .normal)
      signInLabel.text = "Sign In"
      signInDescription.text = "Sign In to your account."
      signInDescription.style(descriptionStyle)
      forgotPwdLabel.text = "Forgot passwrd?"
      dontHaveAccountLabel.text = "Don't have an account yet?"
      signUpBtn.attributedText = NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.underlineStyle : true])
    }

    // Style can be extracted and applied kind of like css \o/
    // but in pure Swift though!
    func commonFieldStyle(_ f:UITextField) {
      f.setLeftPaddingPoints(18.0)
      f.layer.cornerRadius = 2.0
      f.layer.backgroundColor = UIColor(rgba: 0x00000033).cgColor
      f.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
      f.textColor = UIColor.white
      f.attributedPlaceholder =  NSAttributedString(
        string: f.placeholder ?? "",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgba:0xFFFFFF33)])
      f.returnKeyType = .next
    }

    func headerStyle(_ label:UILabel) {
      label.textColor = UIColor(rgb: 0xFFFFFF)
      label.font = UIFont.systemFont(ofSize: 24.0, weight: .regular)
    }

    func descriptionStyle(_ label:UILabel) {
      label.textColor = UIColor(rgb: 0xD8D8D8)
      label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
    }

    func description2Style(_ label:UILabel) {
      label.textColor = UIColor(rgba: 0xFFFFFF90)
      label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
    }

    func signInBtnStyle(_ btn:UIButton) {
      btn.setImage(UIImage(named: Assets.Icons.rightArrow.rawValue), for: .normal)
      btn.setBackgroundColor(color: UIColor(rgb: 0xACAEBF), for: .normal)
      btn.setBackgroundColor(color: UIColor(rgba: 0xACAEBF4C), for: .highlighted)
      btn.setTitleColor(UIColor(rgba: 0xFFFFFF4C), for: .highlighted)
      btn.layer.cornerRadius = 2.0
      btn.layer.borderWidth = 1.0
      btn.layer.borderColor = UIColor(rgb: 0xFFFFFF).cgColor
      btn.layer.shadowColor = UIColor.black.cgColor
      btn.layer.shadowRadius = 10
      btn.layer.shadowOffset = CGSize(width: 0, height: 8)
      btn.layer.shadowOpacity = 0.4
    }

    func linkBtnStyle(_ label:UILabel) {
      label.textColor = UIColor(rgb: 0xFFFFFF)
      label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
    }

    func validationLabelStyle(_ label:UILabel) {
      label.textColor = UIColor(rgb: 0xFC7474)
      label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }
  }

}

