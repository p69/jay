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

extension SwifteaView {
  init() {
    self.init(frame:CGRect.zero)
    // This is only needed for live reload as injectionForXcode
    // doesn't swizzle init methods.
    // Get injectionForXcode here : http://johnholdsworth.com/injection.html
    layout()
  }
}
