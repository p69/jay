//
//  SwifteaView.swift
//  Jay
//
//  Created by Pavel Shyliahau on 10/16/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Swiftea

protocol SwifteaView where Self: UIView {
  associatedtype TModel
  associatedtype TMsg

  func update(dispatch: @escaping Dispatch<TMsg>, model: TModel)
  func layout()
}

protocol SwifteaViewController where Self: UIViewController {
  associatedtype View: SwifteaView
  associatedtype Model: Equatable
  associatedtype Msg

  typealias CreateView = ()->View
  typealias CreateProgram = (View, Model?)->Program<Model, Msg, ()>

  init(createView: @escaping CreateView, createProgram: @escaping CreateProgram)
}


