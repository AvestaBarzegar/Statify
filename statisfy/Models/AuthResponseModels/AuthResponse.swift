//
//  AuthResponse.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import Foundation

struct AuthResponse: Codable {
    
    let accessToken: String
    let expiresIn: Int?
    let refreshToken: String?
    let scope: String?
    let tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case scope = "scope"
        case tokenType = "token_type"
    }
}
