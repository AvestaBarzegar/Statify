//
//  RecentTrack.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-30.
//

import Foundation

struct RecentlyPlayedEndpoint: Endpoint {
    
    var scheme: Scheme.RawValue = Scheme.https.rawValue
    
    var baseURL: String = "api.spotify.com"
    
    var path: String = "/v1/me/player/recently-played"
    
    var pathParameters: String?
    
    var parameters: [URLQueryItem]? = [
        URLQueryItem(name: "limit", value: "50")
    ]
    
    var method: Methods.RawValue? = Methods.get.rawValue
    
    static let shared =  RecentlyPlayedEndpoint()
    
    func urlBuilder() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = parameters
        let url = components.url
        return url
    }
}
