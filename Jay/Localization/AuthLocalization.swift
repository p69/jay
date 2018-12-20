import Foundation

fileprivate let stringsFileName = "Authorization"

enum AuthStrings: String, Localizable {
  case emailPlaceholder = "email placeholder"
  case emailValidationError = "email validation error"

  enum SignIn: String, Localizable {
    case viewControllerTitle = "signin: screen title"
    case signInButton = "signin: signin button"
    case headerLabel = "signin: header"
    case forgotPasswordLabel = "signin: forgot password"
    case dontHaveAccountLabel = "signin: don't have account"
    case signUpButton = "signin: signup button"
    case passwordPlaceholder = "signin: password placeholder"
    case wrongPasswordError = "signin: wrong password error"
    case userNotFoundError = "signin: user %@ not found error"
    case genericError = "signin: generic error"

    var fileName: String {
      return stringsFileName
    }
  }

  enum SignUp: String, Localizable {
    case viewControllerTitle = "signup: screen title"
    case createButton = "signup: create button"
    case heaederLabel = "signup: header"
    case passwordPlaceholder = "signup: password placeholder"
    case retypePasswordPlaceholder = "signup: retype password placeholder"
    case firstnamePlaceholder = "signup: firstname placeholder"
    case lastnamePlaceholder = "signup: lastname placeholder"
    case emailAlreadyUsed = "signup: email is in use error"
    case emailInvalidError = "signup: email is invalid error"
    case passwordsDontMatchError = "signup: passwords don't match error"
    case genericError = "signup: generic error"
    case passwordErrorHint = "signup: password error hint"

    var fileName: String {
      return stringsFileName
    }
  }

  var fileName: String  {
    return stringsFileName
  }
}
