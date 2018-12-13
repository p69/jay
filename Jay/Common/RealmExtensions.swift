import Foundation
import RealmSwift

extension Object {
  func toMain<T:Object>(_ block: @escaping (T)->()) {
    guard let realm = self.realm else {
      return
    }

    let wrapped = ThreadSafeReference(to: self)
    let config = realm.configuration

    Queues.main.async {
      autoreleasepool {
        let mainRealm = try? Realm(configuration: config)
        let object = mainRealm?.resolve(wrapped)
        if let casted = object as? T {
          block(casted)
        }
      }
    }
  }
}
