import Foundation
import UIKit

enum TextStyle {
  static func header(_ label:UILabel) {
    label.textColor = Colors.Text.main.rawValue
    label.font = Fonts.title
  }

  static func description(_ label:UILabel) {
    label.textColor = Colors.Text.main80.rawValue
    label.font = Fonts.subTitle
  }

  static func description2(_ label:UILabel) {
    label.textColor = Colors.Text.main50.rawValue
    label.font = Fonts.display1
  }

  static func validationError(_ label:UILabel) {
    label.textColor = Colors.Text.error.rawValue
    label.font = Fonts.display2
  }

  static func error(_ label:UILabel) {
    label.textColor = Colors.Text.error.rawValue
    label.font = Fonts.display1
    label.contentMode = .scaleToFill
    label.numberOfLines = 2
  }
}
