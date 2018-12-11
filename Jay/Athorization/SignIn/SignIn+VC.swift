import Foundation
import UIKit
import Swiftea

class SignInViewController: BaseViewController<SignIn.View, SignIn.Model, SignIn.Msg> {
  convenience init(router: AuthRouter) {
    let mkProgram = { (view:SignIn.View, model: SignIn.Model?) in SignIn.mkProgramWith(view: view, model: model, router: router)}
    self.init(createView: SignIn.View.init, createProgram: mkProgram)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = "Sign In"
  }
}
