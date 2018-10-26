//
//  View.swift
//  Jay
//
//  Created by Pavel Shyliahau on 10/16/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit
import Swiftea
import Stevia
import ActionKit

extension LoginScreen {
  class LoginView: UIView, SwifteaView {
    typealias TModel = LoginModel
    typealias TMsg = LoginMsg

    let email = UITextField()
    let password = UITextField()
    let login = UIButton()

    convenience init() {
      self.init(frame:CGRect.zero)
      // This is only needed for live reload as injectionForXcode
      // doesn't swizzle init methods.
      // Get injectionForXcode here : http://johnholdsworth.com/injection.html
      createLayout()
    }

    func update(dispatch: @escaping Dispatch<LoginScreen.LoginMsg>, model: LoginScreen.LoginModel) {
      email.text = model.username
      password.text = model.password

      let isBtnEnabled = !model.password.isEmpty && !model.username.isEmpty
      login.isEnabled = isBtnEnabled

      login.addControlEvent(.touchUpInside) {
        dispatch(.onLoginTapped)
      }

      password.addControlEvent(.editingChanged) { ctrl in
        guard let field = ctrl as? UITextField else { return }
        dispatch(.onPasswordChanged(field.text ?? ""))
      }

      email.addControlEvent(.editingChanged) { ctrl in
        guard let field = ctrl as? UITextField else { return }
        dispatch(.onUsernameChanged(field.text ?? ""))
      }
    }

    private func createLayout() {

      // View Hierarchy
      // This essentially does `translatesAutoresizingMaskIntoConstraints = false`
      // and `addSubsview()`. The neat benefit is that
      // (`sv` calls can be nested which will visually show hierarchy ! )
      sv(
        email,
        password,
        login
      )

      // Vertical + Horizontal Layout in one pass
      // With type-safe visual format
      layout(
        100,
        |-email-| ~ 60,
        8,
        |-password-| ~ 60,
        "",
        |login| ~ 80,
        0
      )

      // ⛓ Chainable api
      //        email.top(100).fillHorizontally(m: 8).height(80)
      //        password.Top == email.Bottom + 8
      //        password.fillHorizontally(m: 8).height(80)
      //        login.bottom(0).fillHorizontally().height(80)

      // 📐 Equation based layout (Try it out!)
      //This comes in handy to cover tricky layout cases
      //        email.Top == Top + 100
      //        email.Left == Left + 8
      //        email.Right == Right - 8
      //        email.Height == 80
      //
      //        password.Top == email.Bottom + 8
      //        password.Left == Left + 8
      //        password.Right == Right - 8
      //        password.Height == 80
      //
      //        password.Top == email.Bottom + 8
      //        password.Left == Left + 8
      //        password.Right == Right - 8
      //        password.Height == 80
      //
      //        login.Left == Left
      //        login.Right == Right
      //        login.Bottom == Bottom
      //        login.Height == 80


      // Styling 🎨
      backgroundColor = .gray
      email.style(commonFieldStyle)
      password.style(commonFieldStyle).style { f in
        f.isSecureTextEntry = true
        f.returnKeyType = .done
      }
      login.backgroundColor = .lightGray

      // Content 🖋
      email.placeholder = "Email"
      password.placeholder = "Password"
      login.setTitle("Login", for: .normal)
    }

    // Style can be extracted and applied kind of like css \o/
    // but in pure Swift though!
    func commonFieldStyle(_ f:UITextField) {
      f.borderStyle = .roundedRect
      f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
      f.returnKeyType = .next
    }
  }

}

