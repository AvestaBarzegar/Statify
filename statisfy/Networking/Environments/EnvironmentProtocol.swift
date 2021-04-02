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
