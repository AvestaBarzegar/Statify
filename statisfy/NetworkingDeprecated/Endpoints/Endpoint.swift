//
//  Endpoint.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import Foundation

enum Methods: String {
    
    case get = "GET"
    case post = "POST"
}

enum Scheme: String {
    
    case http
    case https
}

protocol Endpoint {
    
    /// HTTP or HTTPS
    var scheme: Scheme.RawValue { get }
    
    /// Example:  api.spotify.com
    var baseURL: String { get }
    
    /// Example: /v1/me/top/
    var path: String { get }
    
    var pathParameters: String? { get }
    
    /// Example: [URLQueryItem(name: "api_key", value: "API_KEY)]
    var parameters: [URLQueryItem]? { get }
    
    /// Example: "GET"
    var method: Methods.RawValue? { get }
    
    func urlBuilder() -> URL?
    
}
