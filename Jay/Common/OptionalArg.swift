import Foundation

enum OptionalArg<T> {
  case some(T), none
}

extension OptionalArg {
  var value: T? {
    switch self {
    case .some(let val):
      return val
    case .none:
      return nil
    }
  }
}

func nilArg<T>() -> OptionalArg<T?> {
  return OptionalArg<T?>.some(Optional<T>.none)
}
