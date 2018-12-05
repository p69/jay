//
//  UsersRepository.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/29/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

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
