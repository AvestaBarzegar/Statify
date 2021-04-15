//
//  UserEndpoint.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-10.
//

import Foundation

public enum UserAPI {
    case user
    case token(code: String)
    case refreshToken
}

extension UserAPI: EndPointType {
    
    var baseURL: URL {
        switch self {
        case .user:
            let baseURL = "https://api.spotify.com"
            let url = URL(string: baseURL)
            return url!
        case .token:
            let baseURL = "http://localhost:80"
            let url = URL(string: baseURL)
            return url!
        case .refreshToken:
            let baseURL = "http://localhost:80"
            let url = URL(string: baseURL)
            return url!
        }
    }
    
    var path: String {
        switch self {
        case .user:
            return "/v1/me"
        case .token:
            return "/api/token"
        case .refreshToken:
            return "/api/refresh_token"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .user:
            return .get
        case .token:
            return .post
        case .refreshToken:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .user:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                            urlParameters: nil,
                                            additionalHeaders: headers)
        case .token(code: let code):
            let bodyParameters: Parameters = ["code": code]
            return .requestURLBodyEncoded(bodyParameters: bodyParameters,
                                          urlParameters: nil)
        default:
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .user:
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Authorization": "Bearer \(AuthManager.shared.accessToken ?? "")"
            ]
            return headers
        case .token:
            return nil
        default:
            return nil
        }
    }
    
}
