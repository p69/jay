import Foundation
import UIKit
import Jay_Domain

class SignUpViewController: BaseViewController<SignUp.View, SignUp.Model, SignUp.Msg> {
  convenience init(router: AuthRouter) {
    let dependencies = SignUp.Dependencies(
      router: router,
      settings: AppSettings.shared)
    let mkProgram = { (view:SignUp.View, model: SignUp.Model?) in
      SignUp.mkProgramWith(view: view, model: model, dependencies: dependencies)
    }

    self.init(createView: SignUp.View.init, createProgram: mkProgram)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = AuthStrings.SignUp.viewControllerTitle.localized
  }
}
