//
//  File.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-01.
//

import Foundation

/// Environments enum.
enum APIEnvironment: EnvironmentProtocol {
    
    /// The development environment.
    case development
    /// The production environment.
    case production
    
    /// The default HTTP request headers for a given environment.
    
    var headers: RequestHeaders? {
        switch self {
        case .development:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token") ?? "")",
                "Accept": "application/json"
            ]
        case .production:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token") ?? "")",
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
