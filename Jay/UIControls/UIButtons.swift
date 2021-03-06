import Foundation
import UIKit

class ButtonWithIcon: SimpleHighlightedButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    if let icon = imageView {
      imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
      titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: icon.frame.width)
    }
  }
}

class SimpleHighlightedButton: UIButton {
  override var isEnabled: Bool {
    didSet {
      self.alpha = self.isEnabled ? 1.0 : 0.3
    }
  }

  override var isHighlighted: Bool {
    didSet {
      if let borderColor = self.layer.borderColor {
        let newColor = UIColor(cgColor: borderColor).withAlphaComponent(isHighlighted ? 0.3 : 1.0)
        self.layer.borderColor = newColor.cgColor
      }
    }
  }
}
