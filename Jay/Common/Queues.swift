import Foundation
import Dispatch

enum Queues {
  static let computation = DispatchQueue(label: "background computations queue", qos: DispatchQoS.background)
  static let main = DispatchQueue.main
}
