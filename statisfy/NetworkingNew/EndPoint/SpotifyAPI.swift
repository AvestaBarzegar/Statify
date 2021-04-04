//
//  TrackAPI.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-03.
//

import Foundation

public enum TimeRange: String {
    case shortTerm = "short_term"
    case mediumTerm = "medium_term"
    case longTerm = "long_term"
}

public enum SpotifyAPI {
    case artist(timeRange: TimeRange)
    case track(timeRange: TimeRange)
}

extension SpotifyAPI: EndPointType {
    
    var baseURL: URL {
        let baseURL = "https://api.spotify.com"
        let url = URL(string: baseURL)
        return url!
    }
    
    var path: String {
        switch self {
        case .artist:
            return "/v1/me/top/artists"
        case .track:
            return "/v1/me/top/tracks"
        }

    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        var parameters: Parameters = [
            "limit": "50",
            "offset": "0"
        ]
        switch self {
        case .track(timeRange: let timeRange):
            parameters["time_range"] = timeRange.rawValue
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: parameters,
                                                additionalHeaders: headers)
        case .artist(timeRange: let timeRange):
            parameters["time_range"] = timeRange.rawValue
            return .requestParametersAndHeaders(bodyParameters: nil,
                                            urlParameters: parameters,
                                            additionalHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(AuthManager.shared.accessToken ?? "")"
        ]
        return headers
    }
    
}
