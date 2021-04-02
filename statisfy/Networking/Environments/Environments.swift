//
//  Environments.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-01.
//

import Foundation

/// Protocol to which environments must conform.
protocol EnvironmentProtocol {
    /// The default HTTP request headers for the environment.
    func headers(token: String) -> RequestHeaders
    /// The base URL of the environment.
    var baseURL: String { get }

}

/// Environments enum.
enum APIEnvironment: EnvironmentProtocol {
    /// The development environment.
    case development
    /// The production environment.
    case production
    
    /// The default HTTP request headers for a given environment.
    func headers(token: String) -> RequestHeaders {
        switch self {
        case .development:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        case .production:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        }
    }
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://api.spotify.com"
        case .production:
            return "https://api.spotify.com"
        }
    }

}
