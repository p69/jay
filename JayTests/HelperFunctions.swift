//
//  HelperFunctions.swift
//  JayTests
//
//  Created by Pavel Shyliahau on 12/4/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import Nimble
import Jay_Domain

func expectResultError<T, E>(_ result: Result<T,E>, block: (E)->()) {
  switch result {
  case .ok(let x):
    fail("Expected failed result, but received success with value \(x)")
  case .error(let e):
    block(e)
  }
}

func expectResultOk<T, E>(_ result: Result<T,E>, block: (T)->()) {
  switch result {
  case .ok(let x):
    block(x)
  case .error(let e):
    fail("Expected succeeded result, but received error with value \(e)")
  }
}
