import Foundation
import Quick
import Nimble
import RealmSwift
@testable import Jay
import Jay_Domain
import KeychainSwift


class DomainAuthSpec: QuickSpec {
  let existedUsers: [User] = [
    User(firstName: "joey", lastName: "tribiani", email: "j.tribiani@gmail.com")
  ]

  let existedUserPwd = "!password2"

  var realmConfig = Realm.Configuration()
  //MARK: keep strong reference to inMemory Realm to prevent clearing all data
  var realm: Realm!

  var context: AuthContext {
    return AuthContext(repository:
      RealmUsersRepository(withConfig: realmConfig, withKeychain: KeychainSwift(keyPrefix: "test_")))
  }

  override func spec() {
    super.spec()

    beforeSuite {
      self.realmConfig.inMemoryIdentifier = self.name
      self.realm = try! Realm(configuration: self.realmConfig)

      let joey = self.existedUsers[0]
      _ = Auth
        .createNew(email: joey.email, firstName: joey.firstName, lastName: joey.lastName, pwd: self.existedUserPwd, retypePwd: self.existedUserPwd)
        .run(self.context)
    }

    //MARK: - Auth.exists(email:)
    describe("Users exists") {

      it("provides invalid email") {
        let email = "p.shilyagov_gmail.com"
        let exists = Auth.exists(email: email)
        let existsResult = exists.run(self.context)

        expect(existsResult) == false
      }

      it("provides valid email which is not saved") {
        let email = "gipsy@gmail.com"
        let exists = Auth.exists(email: email)
        let existsResult = exists.run(self.context)

        expect(existsResult) == false
      }

      it("provides valid email which is saved") {
        let email = self.existedUsers[0].email
        let exists = Auth.exists(email: email)
        let existsResult = exists.run(self.context)

        expect(existsResult) == true
      }
    }

    //MARK: - Auth.createNew(email:firstName:lastName:pwd:)
    describe("Create new user") {

      it("with invalid email") {
        let email = "p.shilyagov_gmail.com"

        let newUserResult = Auth.createNew(email: email, firstName: "", lastName: "", pwd: "", retypePwd: "").run(self.context)

        expectResultError(newUserResult) { error in
          switch error {
          case RegistrationError.invalidEmail:
            break
          default:
            fail("Must be invalidEmail error, but got \(error)")
          }
        }
      }

      it("with invalid password (short)") {
        let email = "p.shilyagov@gmail.com"
        let password = "1234567"

        let newUserResult = Auth.createNew(email: email, firstName: "", lastName: "", pwd: password, retypePwd: password).run(self.context)

        expectResultError(newUserResult) { error in
          switch error {
          case RegistrationError.weakPassword(_):
            break
          default:
            fail("Must be weakPassword error, but got \(error)")
          }
        }
      }

      it("with invalid password (no alphabet)") {
        let email = "p.shilyagov@gmail.com"
        let password = "12345678"

        let newUserResult = Auth.createNew(email: email, firstName: "", lastName: "", pwd: password, retypePwd: password).run(self.context)

        expectResultError(newUserResult) { error in
          switch error {
          case RegistrationError.weakPassword(_):
            break
          default:
            fail("Must be weakPassword error, but got \(error)")
          }
        }
      }

      it("with invalid password (no special char)") {
        let email = "p.shilyagov@gmail.com"
        let password = "a2345678"

        let newUserResult = Auth.createNew(email: email, firstName: "", lastName: "", pwd: password, retypePwd: password).run(self.context)

        expectResultError(newUserResult) { error in
          switch error {
          case RegistrationError.weakPassword(_):
            break
          default:
            fail("Must be weakPassword error, but got \(error)")
          }
        }
      }

      it("when retype doesn't match password") {
        let email = "p.shilyagov@gmail.com"
        let password = "a234567!"
        let retype = "a234567*"

        let newUserResult = Auth.createNew(email: email, firstName: "", lastName: "", pwd: password, retypePwd: retype).run(self.context)

        expectResultError(newUserResult) { error in
          switch error {
          case RegistrationError.retypePwdError:
            break
          default:
            fail("Must be retypePwdError error, but got \(error)")
          }
        }
      }

      it("with valid data") {
        let email = "p.shilyagov@gmail.com"
        let password = "a234567!"
        let retype = "a234567!"
        let firstName = "Pavel"
        let lastName = "Shilyagov"

        let newUserResult = Auth.createNew(email: email, firstName: firstName, lastName: lastName, pwd: password, retypePwd: retype).run(self.context)

        expectResultOk(newUserResult) { (user:User) in
          expect(user.email) == email
          expect(user.firstName) == firstName
          expect(user.lastName) == lastName
        }
      }
    }

    describe("Login user") {
      it("invalid email") {
        let email = "j.tribiani_gmail.com"
        let password = self.existedUserPwd
        let loginResult = Auth.tryLogin(email: email, pwd: password).run(self.context)
        expectResultError(loginResult) { error in
          switch error {
          case LoginError.notFound(_):
            break
          default:
            fail("Must be notFound error, but got \(error)")
          }
        }
      }
    }

    describe("Login user") {
      it("invalid password") {
        let email = self.existedUsers[0].email
        let password = self.existedUserPwd + "____"
        let loginResult = Auth.tryLogin(email: email, pwd: password).run(self.context)
        expectResultError(loginResult) { error in
          switch error {
          case LoginError.wrongPassword(_):
            break
          default:
            fail("Must be wrongPassword error, but got \(error)")
          }
        }
      }
    }

    describe("Login user") {
      it("valid data") {
        let email = self.existedUsers[0].email
        let password = self.existedUserPwd
        let loginResult = Auth.tryLogin(email: email, pwd: password).run(self.context)
        expectResultOk(loginResult) { user in
          expect(user.email) == email
        }
      }
    }


  }
}
