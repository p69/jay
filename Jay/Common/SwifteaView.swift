import Foundation
import UIKit

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


