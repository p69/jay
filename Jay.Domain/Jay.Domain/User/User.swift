//
//  User.swift
//  Jay
//
//  Created by Pavel Shyliahau on 11/9/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation
import RealmSwift

public class User: Object {
  @objc dynamic
  public var firstName: String = ""

  @objc dynamic
  public var lastName: String = ""

  @objc dynamic
  public var email: String = ""

  @objc dynamic
  public var avatarUrlString: String? = nil

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
