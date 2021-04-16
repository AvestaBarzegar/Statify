//
//  EndpointProtocol.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-03.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
