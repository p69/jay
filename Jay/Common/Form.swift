import Foundation
import UIKit

//MARK: represents possible states of typical input
enum InputFieldModel: Equatable {
  case valid(_ value: String)
  case invalid(value: String, error: String)
}

extension InputFieldModel {
  var value: String {
    switch self {
    case .valid(let val):
      return val
    case .invalid(let val, _):
      return val
    }
  }

  var error: String? {
    switch self {
    case .valid(_):
      return nil
    case .invalid(_, let error):
      return error
    }
  }
}

extension InputFieldModel {
  func setError(with error: String = "") -> InputFieldModel {
    switch self {
    case .valid(let val):
      return .invalid(value: val, error: error)
    default:
      return self
    }
  }
}


extension UITextField {
  func apply(model: InputFieldModel, with errorLabel: UILabel? = nil) {
    switch model {
    case .valid(let val):
      self.style(EditText.validInput)
      self.text = val
      errorLabel?.isHidden = true
      errorLabel?.text = nil

    case .invalid(let val, let error):
      self.style(EditText.invalidInput)
      self.text = val
      errorLabel?.isHidden = false
      errorLabel?.text = error
    }
  }
}
