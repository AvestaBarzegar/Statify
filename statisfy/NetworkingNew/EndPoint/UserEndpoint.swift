//
//  UserEndpoint.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-10.
//

import Foundation

public enum UserAPI {
    case user
}

extension UserAPI: EndPointType {
    
    var baseURL: URL {
        let baseURL = "https://api.spotify.com"
        let url = URL(string: baseURL)
        return url!
    }
    
    var path: String {
        switch self {
        case .user:
            return "/v1/me"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .user:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .user:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                            urlParameters: nil,
                                            additionalHeaders: headers)
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
        }
    }
    
    
}
