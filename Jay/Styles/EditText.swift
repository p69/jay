import Foundation
import UIKit

enum EditText {
  static func loginInput(_ f:UITextField) {
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

  static func secure(_ f:UITextField) {
    f.isSecureTextEntry = true
    f.returnKeyType = .done
  }
}

