//
//  UsersRepository.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/26/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import KeychainSwift
import Jay_Domain
import RealmSwift

fileprivate let usersDbFileName = "users"
fileprivate let defaultUsersRealmConfig: Realm.Configuration = {
  var config = Realm.Configuration()
  config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(usersDbFileName).realm")
  config.objectTypes = [User.self]
  return config
}()

class RealmUsersRepository: UsersRepository {

  private let realmConfig: Realm.Configuration
  private let keychain: KeychainSwift

  private lazy var realm = { try! Realm(configuration: realmConfig) }()

  init(withConfig config: Realm.Configuration = defaultUsersRealmConfig,
       withKeychain keychain: KeychainSwift = KeychainSwift()) {
    self.realmConfig = config
    self.keychain = keychain
  }

  func getAll() -> Result<Results<User>, UsersRepositoryError> {
    return .ok(realm.objects(User.self))
  }

  func add(newUser: User, password: String) -> Result<User, UsersRepositoryError> {
    return findBy(email: newUser.email)
      .inverse(onOk: {_ in .alreadyExist(message: "User \(newUser.email) already exist")}, onError: {_ in newUser})
      .bind { [unowned self] user in self.addInternal(newUser: user, password: password) }
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
    let user = realm.objects(User.self).first(where: {x in x.email == email})
    return user != nil ? .ok(user!) : .error(.notFound(message: "Couldn't find user with email \(email)"))
  }

  func verifyPwd(for email: String, pwd: String) -> Result<(), UsersRepositoryError> {
    if let pwdFromKeychain:String = keychain.get(email) {
      return pwdFromKeychain == pwd ? .ok(()) : .error(.wrongPassword)
    }
    return .error(.notFound(message: "Couldn't find password for user \(email)"))
  }
}


