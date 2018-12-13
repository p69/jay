import Foundation
import RealmSwift

@objcMembers
public class User: Object {
  public dynamic var firstName: String = ""
  public dynamic var lastName: String = ""
  public dynamic var email: String = ""
  public dynamic var avatarUrlString: String? = nil

  public override static func primaryKey() -> String? {
    return "email"
  }
}

extension User {
  public convenience init(firstName: String, lastName: String, email: String, avatar: String? = nil) {
    self.init()
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.avatarUrlString = avatar
  }
}
