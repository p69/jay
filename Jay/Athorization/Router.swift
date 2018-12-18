import Foundation
import UIKit

protocol AuthRouter {
  func goToSignUp()
  func goBack()
  func goToHome()
}

struct DefaultAuthRouter: AuthRouter {
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func goToSignUp() {
    navigationController.pushViewController(SignUpViewController(router: self), animated: true)
  }

  func goBack() {
    navigationController.popViewController(animated: true)
  }

  func goToHome() {
    navigationController.showDetailViewController(HomeNavigationController(), sender: nil)
  }
}
