import Foundation
import RealmSwift

public protocol UsersRepository {
  func getAll() -> Result<Results<User>, UsersRepositoryError>
  func add(newUser: User, password: String) -> Result<User, UsersRepositoryError>
  func findBy(email:String) -> Result<User, UsersRepositoryError>
  func verifyPwd(for email: String, pwd: String) -> Result<(), UsersRepositoryError>
}

public enum UsersRepositoryError: Error {
  case generic(message: String, cause: Error)
  case alreadyExist(message: String)
  case notFound(message: String)
  case wrongPassword
}

extension UsersRepositoryError: Equatable {
  public static func == (lhs: UsersRepositoryError, rhs: UsersRepositoryError) -> Bool {
    switch (lhs, rhs) {
    case (.generic(let lMsg, let lCause), .generic(let rMsg, let rCause)):
      return lMsg == rMsg && lCause == rCause
    case (.alreadyExist(let lMsg), .alreadyExist(let rMsg)):
      return lMsg == rMsg
    case (.notFound(let lMsg), .notFound(let rMsg)):
      return lMsg == rMsg
    case (.wrongPassword, .wrongPassword):
      return true
    default:
      return false
    }
  }
}
