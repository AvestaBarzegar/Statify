//
//  Requests.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-01.
//

import Foundation

/// The request type that matches the URLSessionTask types.
enum RequestType {
    /// Will translate to a URLSessionDataTask.
    case data
    /// Will translate to a URLSessionDownloadTask.
    case download
    /// Will translate to a URLSessionUploadTask.
    case upload
}

/// The expected remote response type.
enum ResponseType {
    /// Used when the expected response is a JSON payload.
    case json
    /// Used when the expected response is a file.
}

/// HTTP request methods.
enum RequestMethod: String {
    /// HTTP GET
    case get = "GET"
    /// HTTP POST
    case post = "POST"
    /// HTTP PUT
    case put = "PUT"
    /// HTTP PATCH
    case patch = "PATCH"
    /// HTTP DELETE
    case delete = "DELETE"
}

/// Type alias used for HTTP request headers.
typealias RequestHeaders = [String: String]
/// Type alias used for HTTP request parameters. Used for query parameters for GET requests
typealias RequestParameters = [String: Any?]
/// Type alias used for HTTP request download/upload progress.
typealias ProgressHandler = (Float) -> Void

protocol RequestProtocol {
    
    /// The path that will be appended to the API's base URL.
    var path: String { get }
    
    /// The HTTP method.
    var method: RequestMethod { get }
    
    /// The HTTP Headers.
    var headers: RequestHeaders? { get }
    
    /// The request parameters used for query parameters for a GET request
    var parameters: RequestParameters? { get }
    
    /// The request type.
    var requestType: RequestType? { get }
    
    /// The expected response type.
    var responseType: ResponseType? { get }
    
    /// The Upload/download progress handler.
    var progressHandler: ProgressHandler? { get set }
}
