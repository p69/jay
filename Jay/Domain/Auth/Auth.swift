//
//  Auth.swift
//  Jay
//
//  Created by Pavel Shyliahau on 10/26/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import Foundation

enum Auth {
  static let getAccessCodeUri = "/v3/auth/token" //GET
  static let renewTokenUri = "/v3/auth/token" //POST
  static let revokeTokenUri = "/v3/auth/token" //POST

  struct AuthRespone: Codable {
    let id: String //user id
    let refreshTokern: String
    let accessToken: String //token
    let experiesIn: Int //in seconds
    let tokenType: String
    let plan: String
    let state: String
  }

  static func getAccessCode() {

  }
}

extension DeezerClient {
  func getAccessCode() {
    
  }
}
