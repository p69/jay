//
//  Operators.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/30/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation


// MARK - Pipe forward operator
// f(x) is the same as x |> f
// Help us to write code that can be read from left to right
// and can be easy composed
precedencegroup PipeOperatorPrecedence {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
}

infix operator |>: PipeOperatorPrecedence

public func |> <A, B>(arg: A,
                      f: @escaping (A) -> B) -> B {
  return f(arg)
}

// MARK - Kleisli arrow operator
// It's used for monadic functions composition
// For example we can compose two functions which returns Result<T, E>
// let validationComposition =
//    validateAge
//    >=> validateEmail
//    >=> validatePassword
// In this case all functions take the same input (say User type) and return the same Result<User, Error>.
// The result of the compositon has the signature (User)->Result<User, Error>.
// The cool thing, that next function is called only if calling of previous was successful (Result.ok),
// otherwise error is returned immediately.
precedencegroup KleisliOperatorPrecedence {
  associativity: left
  higherThan: PipeOperatorPrecedence
}

infix operator >=>: KleisliOperatorPrecedence
