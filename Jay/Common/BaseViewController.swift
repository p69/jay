//
//  BaseViewController.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/6/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit
import Swiftea
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
  var gradientLayer: CAGradientLayer!

  required convenience init(createView: @escaping CreateView, createProgram: @escaping CreateProgram) {
    self.init(nibName: nil, bundle: nil)
    self.createView = createView
    self.createProgram = createProgram
  }

  func setBackgrounGradient() {
    gradientLayer = CAGradientLayer()

    gradientLayer.frame = UIScreen.main.bounds

    gradientLayer.colors = [
      UIColor(rgb: 0x5F627D).cgColor,
      UIColor(rgb: 0x313347).cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    swifteaView.layer.insertSublayer(gradientLayer, at: 0)
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
