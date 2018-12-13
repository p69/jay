import Foundation
import KeychainSwift
import Jay_Domain
import RealmSwift


struct RealmUsersRepository: UsersRepository {
  private let keychain: KeychainSwift
  private let realm: Realm

  init(with realm: Realm,
       with keychain: KeychainSwift = KeychainSwift()) {
    self.realm = realm
    self.keychain = keychain
  }

  func getAll() -> Result<Results<User>, UsersRepositoryError> {
    return .ok(realm.objects(User.self))
  }

  func add(newUser: User, password: String) -> Result<User, UsersRepositoryError> {
    return findBy(email: newUser.email)
      .inverse(onOk: {_ in .alreadyExist(message: "User \(newUser.email) already exist")}, onError: {_ in newUser})
      .bind { user in self.addInternal(newUser: user, password: password) }
  }

  private func addInternal(newUser: User, password: String) -> Result<User, UsersRepositoryError> {
    do {
      try realm.write {
        realm.add(newUser)
      }
    } catch {
      return .error(.generic(message: "Error while trying to add new user \(newUser.email)", cause: error))
    }

    keychain.set(password, forKey: newUser.email)
    return .ok(newUser)
  }

  func findBy(email: String) -> Result<User, UsersRepositoryError> {
    let user = realm.objects(User.self).first(where: {x in x.email.lowercased() == email.lowercased()})
    return user != nil ? .ok(user!) : .error(.notFound(message: "Couldn't find user with email \(email)"))
  }

  func verifyPwd(for email: String, pwd: String) -> Result<(), UsersRepositoryError> {
    if let pwdFromKeychain:String = keychain.get(email) {
      return pwdFromKeychain == pwd ? .ok(()) : .error(.wrongPassword)
    }
    return .error(.notFound(message: "Couldn't find password for user \(email)"))
  }
}
