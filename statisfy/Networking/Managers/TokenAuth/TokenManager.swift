//
//  TokenManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import Foundation

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
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                    self?.cacheToken(result: result)
                    print(result)
                    completion(true)
                    
                } catch {
                    completion(false)
                }
            }).resume()
        
    }
    
    private func refreshToken() {
        
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken, forKey: "access_token")
        UserDefaults.standard.setValue(result.refreshToken, forKey: "refresh_token")
        let expiryDate = Date().addingTimeInterval(TimeInterval(result.expiresIn))
        UserDefaults.standard.setValue(expiryDate, forKey: "expiration_date")
    }
}
