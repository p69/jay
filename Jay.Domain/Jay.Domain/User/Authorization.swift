//
//  Authorization.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/9/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation

fileprivate let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
fileprivate let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)

//MARK
//1 - Password length is 8.
//2 - One Alphabet in Password.
//3 - One Special Character in Password.
fileprivate let pwdRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
fileprivate let pwdTest = NSPredicate(format: "SELF MATCHES %@", pwdRegEx)

public enum Auth {

  public static func exists(email: String) -> Reader<AuthContext, Bool> {
    return Reader { ctx in
      let find = { (email: String) in
        ctx.repository.findBy(email: email).mapError(RegistrationError.repositoryError)
      }
      //validate email first, then try to find user in db
      let result = email |> validateEmail >=> find

      return result.asBool
    }
  }

  public static func tryLogin(email: String, pwd: String) -> Reader<AuthContext, Result<User, LoginError>> {
    return Reader { ctx in
      ctx.repository
        .findBy(email: email)
        .bind { user in ctx.repository.verifyPwd(for: user.email, pwd: pwd).map { _ in user} }
        .mapError { repoError in
          switch repoError {
          case UsersRepositoryError.notFound:
            return LoginError.notFound(email: email)
          case UsersRepositoryError.wrongPassword:
            return LoginError.wrongPassword(email: email)
          default:
            return LoginError.generic(message: "Error while trying to login with \(email)")
          }
      }
    }
  }

  public static func createNew(email: String, firstName: String, lastName: String,
                        pwd: String, avatar: String? = nil) -> Reader<AuthContext, Result<User, RegistrationError>> {
    return Reader { ctx in
      let newUser = User()
      newUser.email = email
      newUser.firstName = firstName
      newUser.lastName = lastName
      newUser.avatarUrlString = avatar
      //MARK - tuple for passing it through all the validation and saving functions
      //We need it to make composition with Kleisli(>=>) and Pipe(|>)
      let newUserInput: (user:User, pwd: String) = (user: newUser, pwd: pwd)

      let validateEmailFunc = { (input:(user:User, pwd: String)) in
        validateEmail(input.user.email).map{_ in input}
      }

      let validatePwdFunc = { (input:(user:User, pwd: String)) in
        validatePwd(input.pwd).map{_ in input}
      }

      let save = { (input:(user:User, pwd: String)) in
        ctx.repository
          .add(newUser: input.user, password: input.pwd)
          .mapError(RegistrationError.repositoryError)
      }

      return newUserInput
        |> validateEmailFunc
        >=> validatePwdFunc
        >=> save
    }
  }

  public static func validateEmail(_ email: String) -> Result<String, RegistrationError> {
    let emailIsValid = emailTest.evaluate(with: email)
    return emailIsValid ? .ok(email) : .error(.invalidEmail)
  }

  public static func validatePwd(_ password: String) -> Result<String, RegistrationError> {
    let pwdIsValid = pwdTest.evaluate(with: password)
    return pwdIsValid ? .ok(password) : .error(.weakPassword(hint: "Length 8. At least one alphabet and one special character"))
  }
}


public struct AuthContext {
  let repository: UsersRepository

  public init(repository: UsersRepository) {
    self.repository = repository
  }
}

public enum LoginError: Equatable {
  case generic(message: String)
  case notFound(email: String)
  case wrongPassword(email: String)
}

public enum RegistrationError {
  case invalidEmail
  case alreadyExists
  case weakPassword(hint: String)
  case repositoryError(internal: UsersRepositoryError)
}
