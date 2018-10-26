//
//  SwifteaView.swift
//  Jay
//
//  Created by Pavel Shyliahau on 10/16/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Swiftea

protocol SwifteaView {
  associatedtype TModel
  associatedtype TMsg

  func update(dispatch: @escaping Dispatch<TMsg>, model: TModel)
}
