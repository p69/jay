//
//  Text.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/10/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit

enum TextStyle {
  static func header(_ label:UILabel) {
    label.textColor = UIColor(rgb: 0xFFFFFF)
    label.font = UIFont.systemFont(ofSize: 24.0, weight: .regular)
  }

  static func description(_ label:UILabel) {
    label.textColor = UIColor(rgb: 0xD8D8D8)
    label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
  }

  static func description2(_ label:UILabel) {
    label.textColor = UIColor(rgba: 0xFFFFFF90)
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
  }

  static func validationError(_ label:UILabel) {
    label.textColor = UIColor(rgb: 0xFC7474)
    label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
  }

  static func error(_ label:UILabel) {
    label.textColor = UIColor(rgb: 0xFC7474)
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
  }
}
