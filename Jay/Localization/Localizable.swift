import Foundation

protocol Localizable {
  var fileName: String { get }
  var localized: String { get }
  //MARK - there is no Splat opeartor in Swift for passing array
  //as variadic parameters, so this is straightforward workaroaround
  func localized(_ arg: CVarArg)->String
  func localized(_ arg1: CVarArg, _ arg2: CVarArg)->String
  func localized(_ arg1: CVarArg, _ arg2: CVarArg, _ arg3: CVarArg)->String
  func localized(_ arg1: CVarArg, _ arg2: CVarArg, _ arg3: CVarArg, _ arg4: CVarArg)->String
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
  var localized: String {
    return rawValue.localized(tableName: fileName)
  }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
  func localized(_ arg: CVarArg)->String {
    return rawValue.localized(tableName: fileName, arg)
  }
  func localized(_ arg1: CVarArg, _ arg2: CVarArg)->String {
    return rawValue.localized(tableName: fileName, arg1, arg2)
  }
  func localized(_ arg1: CVarArg, _ arg2: CVarArg, _ arg3: CVarArg)->String {
    return rawValue.localized(tableName: fileName, arg1, arg2, arg3)
  }
  func localized(_ arg1: CVarArg, _ arg2: CVarArg, _ arg3: CVarArg, _ arg4: CVarArg)->String {
    return rawValue.localized(tableName: fileName, arg1, arg2, arg3, arg4)
  }
}

fileprivate let defaultTableName = "Localizable"
fileprivate let defaultBundle = Bundle.main

extension String {
  func localized(bundle: Bundle = defaultBundle, tableName: String = defaultTableName) -> String {
    return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
  }

  func localized(bundle: Bundle = defaultBundle, tableName: String = defaultTableName,_ arg: CVarArg) -> String {
    let template = localized(bundle: bundle, tableName: tableName)
    return String(format: template, arg)
  }

  func localized(bundle: Bundle = defaultBundle, tableName: String = defaultTableName,
                 _ arg1: CVarArg, _ arg2: CVarArg) -> String {
    let template = localized(bundle: bundle, tableName: tableName)
    return String(format: template, arg1, arg2)
  }

  func localized(bundle: Bundle = defaultBundle, tableName: String = defaultTableName,
                 _ arg1: CVarArg, _ arg2: CVarArg, _ arg3: CVarArg) -> String {
    let template = localized(bundle: bundle, tableName: tableName)
    return String(format: template, arg1, arg2, arg3)
  }

  func localized(bundle: Bundle = defaultBundle, tableName: String = defaultTableName,
                 _ arg1: CVarArg, _ arg2: CVarArg, _ arg3: CVarArg, _ arg4: CVarArg) -> String {
    let template = localized(bundle: bundle, tableName: tableName)
    return String(format: template, arg1, arg2, arg3, arg4)
  }
}
