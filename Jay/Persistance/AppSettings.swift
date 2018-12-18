import Foundation

struct AppSettings {
  var currentUserEmail: UserDefaultsStorable<String> = "current_user"

  static let shared = AppSettings()

  private init() {}
}
