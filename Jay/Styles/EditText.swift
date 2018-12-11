import Foundation
import UIKit

enum EditText {
  static func loginInput(_ f:UITextField) {
    f.setLeftPaddingPoints(18.0)
    f.layer.cornerRadius = 2.0
    f.layer.backgroundColor = Colors.FormFileds.inputBackground.rawValue.cgColor
    f.font = Fonts.subTitle
    f.textColor = UIColor.white
    f.attributedPlaceholder =  NSAttributedString(
      string: f.placeholder ?? "",
      attributes: [NSAttributedString.Key.foregroundColor: Colors.FormFileds.placeholderColor.rawValue])
    f.returnKeyType = .next
  }

  static func validInput(_ f:UITextField) {
    f.layer.borderWidth = 0.0
    f.layer.borderColor = nil
  }

  static func invalidInput(_ f:UITextField) {
    f.layer.borderWidth = 1.0
    f.layer.borderColor = Colors.invalidInputBorder.rawValue.cgColor
  }

  static func secure(_ f:UITextField) {
    f.isSecureTextEntry = true
    f.returnKeyType = .done
  }
}

