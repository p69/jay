import Foundation
import UIKit
import Stevia
import CoreGraphics

class BaseViewController<TView: SwifteaView, TModel: Equatable, TMsg> : UIViewController, SwifteaViewController {
  typealias View = TView
  typealias Model = TModel
  typealias Msg = TMsg

  var createView: CreateView!
  var createProgram: CreateProgram!

  var swifteaView: TView!
  lazy var swifteaProgram = self.createProgram(self.swifteaView, nil)
  var bgView: GradientView!

  required convenience init(createView: @escaping CreateView, createProgram: @escaping CreateProgram) {
    self.init(nibName: nil, bundle: nil)
    self.createView = createView
    self.createProgram = createProgram
  }

  func setBackgrounGradient() {
    bgView = GradientView()
    bgView.colors = [
      Colors.backgroundGradientStart.rawValue.cgColor,
      Colors.backgroundGradientEnd.rawValue.cgColor
    ]
    bgView.start = CGPoint(x: 0.0, y: 0.0)
    bgView.end = CGPoint(x: 1.0, y: 1.0)
    bgView.contentMode = .redraw

    swifteaView.insertSubview(bgView, at: 0)
    bgView.translatesAutoresizingMaskIntoConstraints = false
    bgView.fillContainer()
  }

  override func loadView() {
    swifteaView = createView()
    setBackgrounGradient()
    view = swifteaView
  }

  override func viewWillAppear(_ animated: Bool) {
    swifteaProgram.run()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    on("INJECTION_BUNDLE_NOTIFICATION") {
      self.loadView()
      let newProgram = self.createProgram(self.swifteaView, self.swifteaProgram.currentModel)
      self.swifteaProgram = newProgram
      self.swifteaProgram.run()
    }
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
