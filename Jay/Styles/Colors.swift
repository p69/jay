import Foundation
import UIKit

/*
 Opacity hex values
 80% - 0xCC
 50% - 0x80
 40% - 0x66
 30% - 0x4D
 20% - 0x33
*/

enum Colors: Color {
  case backgroundGradientStart = 0x5F627DFF
  case backgroundGradientEnd = 0x313347FF
  
  enum Text: Color {
    case main = 0xFFFFFFFF
    case mainHighlighted = 0xFFFFFF66
    case main80 = 0xFFFFFFCC
    case main50 = 0xFFFFFF80
    case error = 0xFC7474FF
  }

  enum Buttons: Color {
    case grey = 0xACAEBFFF
    case greyHighlighted = 0xACAEBF4D
    case greyBorder = 0xFFFFFFFF
    case shadowColor = 0x00000000
  }

  enum FormFileds: Color {
    case inputBackground = 0x00000033
    case placeholderColor = 0xFFFFFF33
  }
}

final class Color: UIColor {
}

extension Color: RawRepresentable {
  public typealias RawValue = UInt

  public convenience init?(rawValue: UInt) {
    self.init(rgba: rawValue)
  }

  public var rawValue: UInt {
    return hex
  }
}

extension Color: ExpressibleByIntegerLiteral {
  typealias IntegerLiteralType = Int

  public convenience init(integerLiteral value: Int) {
    self.init(rgba: UInt(value))
  }
}
