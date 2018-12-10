//
//  OptionalArg.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/10/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation

enum OptionalArg<T> {
  case some(T), none
}

extension OptionalArg {
  var value: T? {
    switch self {
    case .some(let val):
      return val
    case .none:
      return nil
    }
  }
}
