import Foundation
import UIKit

class HomeNavigationController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let mainVC = UIViewController()
    mainVC.view.backgroundColor = .red

    let rootController = RootViewController(mainViewController: mainVC,
                                            topNavigationLeftImage: UIImage(named: Assets.Icons.hamburgerMenu.rawValue))
    let menuVC = MenuViewController()
    menuVC.view.backgroundColor = .green

    let drawerVC = DrawerController(rootViewController: rootController, menuController: menuVC)

    self.addChild(drawerVC)
    view.addSubview(drawerVC.view)
    drawerVC.didMove(toParent: self)
  }
}
