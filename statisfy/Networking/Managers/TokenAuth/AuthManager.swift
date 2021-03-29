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
    case redirectURI = "http://avestabarzegar.com"
}

final class AuthManager: Endpoint {
    
    var scheme: Scheme.RawValue = Scheme.https.rawValue
    
    var baseURL: String = "accounts.spotify.com/"
    
    var path: String = "authorize"
    
    var pathParameters: String? = "?response_type=code&client_id=\(ClientInfo.clientId.rawValue)"
    
    var scopes: String = "&scope=\(AuthConstants.topScope.rawValue),\(AuthConstants.recentScope.rawValue)"
    
    var redirectURI: String = "&redirect_uri=\(AuthConstants.redirectURI.rawValue)"
    
    var showDialog: String = "&show_dialog=TRUE"
    
    var parameters: [URLQueryItem]?
    
    var method: Methods.RawValue?
    
    func urlBuilder() -> String? {
        let base: String = scheme + baseURL + path
        guard let pathParameters = pathParameters else { return nil }
        let params: String = pathParameters + scopes
        let url: String = base + params + redirectURI + showDialog
        return url
    }
    
    static let shared = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    public var signInURL: URL? {
        guard let string = urlBuilder() else { return nil }
        guard let url = URL(string: string) else { return nil }
        return url
    }
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expiration_date") as? Date
    }
    
    var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
}
