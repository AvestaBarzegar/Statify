//
//  AuthAPI.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-04.
//

import Foundation

enum AuthConstants: String {
    
    case topScope = "user-top-read"
    case recentScope = "user-read-recently-played"
    case redirectURI = "http://avestabarzegar.com"
}

public enum AuthAPI {
    case auth
    case token
}

extension AuthAPI: EndPointType {
    
    var baseURL: URL {
        switch self {
        case .auth:
            let urlString = "https://accounts.spotify.com"
            let url = URL(string: urlString)
            return url!
        case .token:
            let urlString = "https://accounts.spotify.com"
            let url = URL(string: urlString)
            return url!
        }
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/authorize"
        case .token:
            return "/api/token"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .auth:
            return .get
        case .token:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .auth:
            var params: Parameters = [
                "client_id": ClientInfo.clientId.rawValue,
                "response_type": "code",
                "redirect_uri": AuthConstants.redirectURI,
                "scope": "\(AuthConstants.topScope.rawValue),\(AuthConstants.recentScope.rawValue)",
                "show_dialog": "true"
            ]
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: params)
        case .token:
            var params: Parameters = [
                
            ]
        }
    }
    
    var headers: HTTPHeaders? {
        <#code#>
    }
    
    
}
