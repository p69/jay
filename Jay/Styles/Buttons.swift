//
//  Buttons.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/10/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit

enum ButtonStyle {
  static func grey(with icon: UIImage) -> (UIButton)->() {
    return { btn in
      btn.setImage(icon, for: .normal)
      btn.setBackgroundColor(color: Colors.Buttons.grey.rawValue, for: .normal)
      btn.setBackgroundColor(color: Colors.Buttons.greyHighlighted.rawValue, for: .highlighted)
      btn.setTitleColor(Colors.Text.main.rawValue, for: .normal)
      btn.setTitleColor(Colors.Text.mainHighlighted.rawValue, for: .highlighted)
      btn.layer.cornerRadius = 2.0
      btn.layer.borderWidth = 1.0
      btn.layer.borderColor = Colors.Buttons.greyBorder.rawValue.cgColor
      btn.layer.shadowColor = Colors.Buttons.shadowColor.rawValue.cgColor
      btn.layer.shadowRadius = 10
      btn.layer.shadowOffset = CGSize(width: 0, height: 8)
      btn.layer.shadowOpacity = 0.4
    }
  }

  static func linkButton(_ btn:UIButton) {
    let text = btn.currentTitle ?? ""
    let commonAttributes : [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.underlineStyle : true,
      NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0, weight: .regular)]

    let normalAttributes = commonAttributes.merging([NSAttributedString.Key.foregroundColor : Colors.Text.main.rawValue], uniquingKeysWith: {a, b in a})

    let highlightedAttributes = commonAttributes.merging([NSAttributedString.Key.foregroundColor : Colors.Text.mainHighlighted.rawValue], uniquingKeysWith: {a, b in a})

    btn.setAttributedTitle(NSMutableAttributedString(string: text, attributes: normalAttributes), for: .normal)
    btn.setAttributedTitle(NSMutableAttributedString(string: text, attributes: highlightedAttributes), for: .highlighted)
    btn.setAttributedTitle(NSMutableAttributedString(string: text, attributes: highlightedAttributes), for: .disabled)
  }

}
