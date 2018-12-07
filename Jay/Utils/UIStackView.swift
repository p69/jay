//
//  UIStackView.swift
//  Jay
//
//  Created by Pavel Shyliahau on 12/7/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: UIView {
  func wrapInHorizontalStack(distribution: UIStackView.Distribution = .equalSpacing,
                             alignment: UIStackView.Alignment = .fill) -> UIStackView {
    return wrapInStack(axis: .horizontal, distribution: distribution, alignment: alignment)
  }

  func wrapInVerticalStack(distribution: UIStackView.Distribution = .equalSpacing,
                           alignment: UIStackView.Alignment = .fill) -> UIStackView {
    return wrapInStack(axis: .vertical, distribution: distribution, alignment: alignment)
  }

  func wrapInStack(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .equalSpacing,alignment: UIStackView.Alignment = .fill) -> UIStackView {
    let stack = UIStackView(arrangedSubviews: self)
    stack.distribution = distribution
    stack.alignment = alignment
    stack.axis = axis
    return stack
  }
}

