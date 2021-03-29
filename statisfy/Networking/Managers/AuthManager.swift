//
//  AuthManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import Foundation

final class AuthManager: Endpoint {
    
    var scheme: Scheme.RawValue = Scheme.https.rawValue
    
    var baseURL: String = "accounts.spotify.com/"
    
    var path: String = "authorize?response_type=code"
    
    var pathParameters: String = "&client_id=\()"
    
    var parameters: [URLQueryItem]
    
    var method: Methods.RawValue
    
    func urlBuilder() -> String? {
        let url = scheme + baseURL + path
        return url
    }
    
    static let shared = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    public var signInURL: URL? {
        let string = '&client_id=' + my_client_id + (scopes ? '&scope=' + encodeURIComponent(scopes) : '') + '&redirect_uri=' + encodeURIComponent(redirect_uri)
        return string
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
