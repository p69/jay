//
//  StoredObject.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/26/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation

protocol StoredObject {
  associatedtype Primitive
  func toPrimitive() -> Primitive?
  static func from(primitive: Primitive) -> Self?
}

protocol SelfStoredObject: StoredObject where Primitive == Self {
}

extension SelfStoredObject {
  func toPrimitive() -> Primitive? {
    return self
  }

  static func from(primitive: Primitive) -> Self? {
    return primitive
  }
}

extension String: SelfStoredObject {
  typealias Primitive = String
}

extension Int: SelfStoredObject {
  typealias Primitive = Int
}

extension Float: SelfStoredObject {
  typealias Primitive = Float
}

extension Double: SelfStoredObject {
  typealias Primitive = Double
}

extension Bool: SelfStoredObject {
  typealias Primitive = Bool
}

extension Data: SelfStoredObject {
  typealias Primitive = Data
}
