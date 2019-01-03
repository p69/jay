import Foundation

//MARK: commands factories

extension Cmd {
  static func of<TMsg>(msg: TMsg) -> Cmd<TMsg> {
    return [{d in d(msg) }]
  }

  static func of<TMsg>(action: @escaping (@escaping Dispatch<TMsg>)->())->Cmd<TMsg> {
    return [action]
  }
}
