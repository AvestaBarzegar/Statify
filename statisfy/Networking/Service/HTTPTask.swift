//
//  HTTPTask.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-03.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestBodyURLEncoded(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}
