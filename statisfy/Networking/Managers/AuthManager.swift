//
//  AuthManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import Foundation

enum AuthConstants: String {
    
    case topScope = "user-top-read"
    case recentScope = "user-read-recently-played"
    case redirectURI = "http://avestabarzegar.com/"
}

final class AuthManager: Endpoint {
    
    var scheme: Scheme.RawValue = Scheme.https.rawValue
    
    var baseURL: String = "accounts.spotify.com/"
    
    var path: String = "authorize"
    
    var pathParameters: String = "?response_type=code&client_id=\(ClientInfo.clientId.rawValue)"
    
    var scopes: String = "&scope=\(AuthConstants.topScope.rawValue),\(AuthConstants.recentScope.rawValue)"
    
    var redirectURI: String = "&redirect_uri=\(AuthConstants.redirectURI.rawValue)"
    
    var parameters: [URLQueryItem]?
    
    var method: Methods.RawValue = Methods.get.rawValue
    
    func urlBuilder() -> String? {
        let url = scheme + baseURL + path + pathParameters + scopes + redirectURI
        return url
    }
    
    static let shared = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    public var signInURL: URL? {
        guard let string = urlBuilder() else { return nil }
        guard let url = URL(string: string) else { return nil }
        return url
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
