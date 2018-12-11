import Foundation
import UIKit

class SignUpViewController: BaseViewController<SignUp.View, SignUp.Model, SignUp.Msg> {
  required convenience init(router: AuthRouter) {
    let mkProgram = { (view:SignUp.View, model: SignUp.Model?) in SignUp.mkProgramWith(view: view, model: model, router: router)}
    self.init(createView: SignUp.View.init, createProgram: mkProgram)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = "Sign Up"
  }
}
