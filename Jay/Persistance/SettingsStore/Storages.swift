import Foundation
import KeychainSwift

protocol StringLiteralBoilerplate {
  init(stringLiteral value: String)
}

extension StringLiteralBoilerplate {
  typealias StringLiteralType = String

  init(stringLiteral value: UnicodeScalarType) {
    self.init(stringLiteral: value)
  }

  init(extendGraphemClusterType value: ExtendedGraphemeClusterType) {
    self.init(stringLiteral: value)
  }
}

struct UserDefaultsStorable<T>: ExpressibleByStringLiteral, StringLiteralBoilerplate where T: StoredObject {
  private let key: String
  private let store = UserDefaults.standard

  init(stringLiteral value: String) {
    self.key = value
  }

  var value: T? {
    get {
      guard let item = store.value(forKey: key) as? T else {
        return nil
      }
      return item
    }
    set {
      store.set(newValue?.toPrimitive(), forKey: key)
    }
  }
}

struct KeychainStorable<T>: ExpressibleByStringLiteral, StringLiteralBoilerplate where T: StoredObject {
  private let key: String
  private let store = KeychainSwift()

  init(stringLiteral value: String) {
    self.key = value
  }

  var value: T? {
    get {
      guard let item = store.get(key) as? T else {
        return nil
      }
      return item
    }
    set {
      guard let item = newValue?.toPrimitive() else {
        return
      }
      switch item {
      case let bool as Bool:
        store.set(bool, forKey: key)
      case let str as String:
        store.set(str, forKey: key)
      case let data as Data:
        store.set(data, forKey: key)
      default:
        return
      }
    }
  }
}
