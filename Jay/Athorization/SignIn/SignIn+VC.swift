import Foundation
import UIKit

class SignInViewController: BaseViewController<SignIn.View, SignIn.Model, SignIn.Msg> {
  convenience init(router: AuthRouter) {
    let deps = SignIn.Dependencies(router: router,
                                   settings: AppSettings.shared)
    let mkProgram = { (view:SignIn.View, model: SignIn.Model?) in SignIn.mkProgramWith(view: view, model: model, dependencies: deps)}
    self.init(createView: SignIn.View.init, createProgram: mkProgram)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = AuthStrings.SignIn.viewControllerTitle.localized
  }
}
