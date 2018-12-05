//
//  Result.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/5/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation

public enum Result<T, E> {
  case ok(T)
  case error(E)
}

//MARK: helper functions
extension Result {
  public func map<B>(_ f: @escaping (T) -> B) -> Result<B, E> {
    switch self {
    case .ok(let x):
      return .ok(f(x))
    case .error(let e):
      return .error(e)
    }
  }

  public func mapError<B>(_ f: @escaping (E) -> B) -> Result<T, B> {
    switch self {
    case .ok(let x):
      return .ok(x)
    case .error(let e):
      return .error(f(e))
    }
  }

  public func bind<B>(_ f: @escaping (T) -> Result<B, E>) -> Result<B, E> {
    return either(onOk: f, onError: Result<B, E>.error)
  }

  public func either<B>(onOk: @escaping (T) -> B, onError: @escaping (E) -> B) -> B {
    switch self {
    case .ok(let x):
      return onOk(x)
    case .error(let e):
      return onError(e)
    }
  }

  public var isOk: Bool {
    return either(onOk: {_ in true}, onError: {_ in false})
  }

  public var isError: Bool {
    return !isOk
  }

  //MARK: ok -> true, error -> false
  public var asBool: Bool {
    return either(onOk: {_ in true}, onError: {_ in false})
  }

  public func inverse(onOk: @escaping (T) -> E, onError: @escaping (E) -> T) -> Result<T, E> {
    switch self {
    case .ok(let x):
      return .error(onOk(x))
    case .error(let x):
      return .ok(onError(x))
    }
  }
}


public func mapOk<A, B, E>(lhs: @escaping (A) -> Result<A, E>,
                           rhs: @escaping (A) -> B) -> (A) -> Result<B, E> {
  return { a in
    lhs(a).map(rhs)
  }
}

public func mapError<A, E, B>(lhs: @escaping (A) -> Result<A, E>,
                              rhs: @escaping (E) -> B) -> (A) -> Result<A, B> {
  return { a in
    lhs(a).mapError(rhs)
  }
}

extension Result {
  public static func >>=<B>(result: Result, f: @escaping  (T) -> Result<B, E>) -> Result<B, E> {
    return result.bind(f)
  }
}

public func >=> <A, B, C, E>(f: @escaping (A) -> Result<B, E>,
                             g: @escaping (B) -> Result<C, E>) -> (A)->Result<C, E> {
  return { a in
    f(a).bind(g)
  }
}
