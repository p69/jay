import Foundation
import UIKit

extension UIColor {
  //MARK: example UIColor(rgba: 0x654265FF
  convenience init(rgba: UInt) {
    self.init(red: CGFloat((rgba & 0xFF000000) >> 24) / 255.0,
              green: CGFloat((rgba & 0x00FF0000) >> 16) / 255.0,
              blue: CGFloat((rgba & 0x0000FF00) >> 8) / 255.0,
              alpha: CGFloat(rgba & 0x000000FF) / 255.0)
  }

  var hex: UInt {
    var fRed: CGFloat = 0
    var fGreen: CGFloat = 0
    var fBlue: CGFloat = 0
    var fAlpha: CGFloat = 0
    if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
      let red = UInt(fRed * 255.0)
      let green = UInt(fGreen * 255.0)
      let blue = UInt(fBlue * 255.0)
      let alpha = UInt(fAlpha * 255.0)
      let rgba = (alpha << 24) + (red << 16) + (green << 8) + blue
      return rgba
    } else {
      return 0x00000000
    }
  }
}
