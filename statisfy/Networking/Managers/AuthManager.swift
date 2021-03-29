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

// MARK: - Token Logic

final class TokenManager: Endpoint {

    var scheme: Scheme.RawValue = Scheme.https.rawValue
    
    var baseURL: String = "accounts.spotify.com/"
    
    var path: String = "api/token/"
    
    var pathParameters: String?
    
    var parameters: [URLQueryItem]? = [
        URLQueryItem(name: "grant_type", value: "authorization_code"),
        URLQueryItem(name: "redirect_uri", value: AuthConstants.redirectURI.rawValue)
        ]
    
    var method: Methods.RawValue? = Methods.post.rawValue
    
    func urlBuilder() -> String? {
        let url = scheme + baseURL + path
        return url
    }
    
    private init() {}
    
    static let shared = TokenManager()
    
    public func exchangeCodeForToken(
        code: String,
        completion: @escaping (Bool) -> Void
    ) {
        // Build up URL
        guard let urlString = urlBuilder() else { return }
        guard let url = URL(string: urlString) else { return }
        
        // build up request Params
        var components = URLComponents()
        var params = parameters
        params?.append(URLQueryItem(name: "code", value: code))
        components.queryItems = params
        
        // Set request method
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = ClientInfo.clientId.rawValue + ":" + ClientInfo.clientSecret.rawValue
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return}
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        // do request
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print("json: \(json)")
                    
                } catch {
                    completion(false)
                }
            }).resume()
        
    }
    
    private func refreshToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
