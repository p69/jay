//
//  UIButton.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/10/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
  /// Sets the background color to use for the specified button state.
  func setBackgroundColor(color: UIColor, for state: UIControl.State) {

    let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)

    UIGraphicsBeginImageContext(minimumSize)

    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(CGRect(origin: .zero, size: minimumSize))
    }

    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    self.clipsToBounds = true
    self.setBackgroundImage(colorImage, for: state)
  }
}
