//
//  Reader.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/27/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation

//MARK - simple Reader Monad for managing dependencies
//E - Enviroment type, used as dependecies context
//A - Result's type
public struct Reader<E, A> {

  public let reader: (E) -> A

  public init(_ reader: @escaping (E) -> A) {
    self.reader = reader
  }

  public func run(_ e: E) -> A {
    return reader(e)
  }

  public func map<B>(_ f: @escaping (A) -> B) -> Reader<E, B> {
    return Reader<E, B>{ e in f(self.reader(e)) }
  }

  public func flatMap<B>(_ f: @escaping (A) -> Reader<E, B>) -> Reader<E, B> {
    return Reader<E, B>{ e in f(self.reader(e)).reader(e) }
  }
}
