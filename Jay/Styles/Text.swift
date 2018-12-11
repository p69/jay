import Foundation
import UIKit

enum TextStyle {
  static func header(_ label:UILabel) {
    label.textColor = Colors.Text.main.rawValue
    label.font = UIFont.systemFont(ofSize: 24.0, weight: .regular)
  }

  static func description(_ label:UILabel) {
    label.textColor = Colors.Text.main80.rawValue
    label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
  }

  static func description2(_ label:UILabel) {
    label.textColor = Colors.Text.main50.rawValue
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
  }

  static func validationError(_ label:UILabel) {
    label.textColor = Colors.Text.error.rawValue
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
  }

  static func error(_ label:UILabel) {
    label.textColor = Colors.Text.error.rawValue
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
  }
}
