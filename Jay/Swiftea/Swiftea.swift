import Foundation

//MARK:
//Simple TEA (The Elm Architecture) engine based on GCD

typealias Cmd<TMsg> = [Effect<TMsg>]
typealias Dispatch<TMsg> = (TMsg) -> ()
typealias Effect<TMsg> = (@escaping Dispatch<TMsg>) -> ()

typealias Init<TModel, TMsg> = () throws -> (TModel, Cmd<TMsg>)
typealias Update<TModel, TMsg> = (TMsg, TModel) throws -> (TModel, Cmd<TMsg>)
typealias View<TModel, TMsg, TView> = (@escaping Dispatch<TMsg>, TModel) -> TView

final class Program<TModel: Equatable, TMsg, TView> {
  let initModel: Init<TModel, TMsg>
  let update: Update<TModel, TMsg>
  let view: View<TModel, TMsg, TView>
  let onError: (Error)->()
  let setState: (@escaping Dispatch<TMsg>, TModel) -> ()

  fileprivate(set) var currentModel: TModel?
  fileprivate(set) var dispatch: Dispatch<TMsg>?

  required init(initModel: @escaping Init<TModel, TMsg>,
                       update: @escaping Update<TModel, TMsg>,
                       view: @escaping View<TModel, TMsg, TView>,
                       onError: @escaping (Error)->(),
                       setState: @escaping (@escaping Dispatch<TMsg>, TModel) -> ()) {
    self.initModel = initModel
    self.update = update
    self.view = view
    self.setState = setState
    self.onError = onError
  }
}

let defaultErrorHandler = {e in debugPrint("Swiftea onError:", e)}

extension Program {
  static func mkSimple(initModel: @escaping Init<TModel, TMsg>,
                              update: @escaping Update<TModel, TMsg>,
                              view: @escaping View<TModel, TMsg, TView>)->Program {
    return Program(
      initModel: initModel,
      update: update,
      view: view,
      onError: defaultErrorHandler,
      setState: { d, m in
        DispatchQueue.main.async {
          let _ = view(d, m)
        }
    })
  }
}

extension Program {
  func run(with queue: DispatchQueue = DispatchQueue.main) {
    do {
      let (initialModel, initialCmds) = try initModel()
      self.currentModel = initialModel

      var dispatch: Dispatch<TMsg>!
      dispatch = {[weak self] msg in
        queue.async {
          guard let self = self, let currentModel = self.currentModel else {
            return
          }
          do {
            let (newModel, cmds) = try self.update(msg, currentModel)
            if newModel != self.currentModel {
              self.currentModel = newModel
              self.setState(dispatch, newModel)
            }
            for cmd in cmds {
              cmd(dispatch)
            }
          } catch {
            self.onError(error)
          }
        }
      }

      self.dispatch = dispatch
      self.setState(dispatch, initialModel)
      for cmd in initialCmds {
        cmd(dispatch)
      }
    } catch {
      onError(error)
    }

  }
}
