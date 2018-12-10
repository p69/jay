//
//  Form.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/10/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit

//MARK: represents possible states of typical input
enum InputField: Equatable {
  case valid(_ value: String)
  case invalid(value: String, error: String)
}

extension InputField {
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

extension UITextField {
  func apply(inputField: InputField, with validationLabel: UILabel, showErrorForEmpty: Bool = false) {
    switch inputField {
    case .valid(let val):
      validationLabel.isHidden = true
      validationLabel.text = nil
      self.text = val
    case .invalid(let val, let error):
      self.text = val
      if val.isEmpty {
        validationLabel.isHidden = !showErrorForEmpty
        validationLabel.text = showErrorForEmpty ? error : nil
      } else {
        validationLabel.isHidden = false
        validationLabel.text = error
      }
    }
  }
}
