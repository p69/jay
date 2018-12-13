import Foundation
import RealmSwift
import Jay_Domain

enum RealmStore {
  enum Users {
    private static let usersDbFileName = "users"
    private static let defaultUsersRealmConfig: Realm.Configuration = {
      var config = Realm.Configuration()
      config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(usersDbFileName).realm")
      debugPrint("Users Realm is located at: ", config.fileURL!)
      config.objectTypes = [User.self]
      return config
    }()

    static var realm: Realm? {
      return try? Realm(configuration: defaultUsersRealmConfig)
    }

    static func background(_ block: @escaping (Realm)->()) {
      Queues.computation.async{
        if let realm = realm {
          block(realm)
        }
      }
    }

    static func main(_ block: @escaping (Realm)->()) {
      Queues.main.async{
        if let realm = realm {
          block(realm)
        }
      }
    }
  }
}
