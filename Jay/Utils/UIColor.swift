//
//  UIColor.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/6/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  //MARK: example UIColor(rgb: 0x654265
  convenience init(rgb: UInt) {
    self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgb & 0x0000FF) / 255.0,
              alpha: 1.0)
  }

  //MARK: example UIColor(rgba: 0x654265FF
  convenience init(rgba: UInt) {
    self.init(red: CGFloat((rgba & 0xFF000000) >> 24) / 255.0,
              green: CGFloat((rgba & 0x00FF0000) >> 16) / 255.0,
              blue: CGFloat((rgba & 0x0000FF00) >> 8) / 255.0,
              alpha: CGFloat(rgba & 0x000000FF) / 255.0)
  }
}
