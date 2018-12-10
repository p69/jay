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
      btn.setBackgroundColor(color: UIColor(rgb: 0xACAEBF), for: .normal)
      btn.setBackgroundColor(color: UIColor(rgba: 0xACAEBF4C), for: .highlighted)
      btn.setTitleColor(UIColor(rgba: 0xFFFFFF4C), for: .highlighted)
      btn.layer.cornerRadius = 2.0
      btn.layer.borderWidth = 1.0
      btn.layer.borderColor = UIColor(rgb: 0xFFFFFF).cgColor
      btn.layer.shadowColor = UIColor.black.cgColor
      btn.layer.shadowRadius = 10
      btn.layer.shadowOffset = CGSize(width: 0, height: 8)
      btn.layer.shadowOpacity = 0.4
    }
  }

  static func linkButton(_ label:UILabel) {
    let text = label.text ?? ""
    label.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.underlineStyle : true])
    label.textColor = UIColor(rgb: 0xFFFFFF)
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
  }

}
