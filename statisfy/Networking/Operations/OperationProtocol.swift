//
//  OperationProtocol.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-01.
//

import Foundation

/// The type to which all operations must conform in order to execute and cancel a request.
protocol OperationProtocol {
    associatedtype Output

    /// The request to be executed.
    var request: RequestProtocol { get }

    /// Execute a request using a request dispatcher.
    /// - Parameters:
    ///   - requestDispatcher: `RequestDispatcherProtocol` object that will execute the request.
    ///   - completion: Completion block.
    func execute(in requestDispatcher: RequestDispatcherProtocol, completion: @escaping (Output) -> Void)

    /// Cancel the operation.
    func cancel()
}

/// The expected result of an API Operation.
enum OperationResult {
    /// JSON reponse.
    case json(_ : Any?, _ : HTTPURLResponse?)
    /// A downloaded file with an URL.
    case file(_ : URL?, _ : HTTPURLResponse?)
    /// An error.
    case error(_ : Error?, _ : HTTPURLResponse?)
}

/// Protocol to which a request dispatcher must conform to.
protocol RequestDispatcherProtocol {

    /// Required initializer.
    /// - Parameters:
    ///   - environment: Instance conforming to `EnvironmentProtocol` used to determine on which environment the requests will be executed.
    ///   - networkSession: Instance conforming to `NetworkSessionProtocol` used for executing requests with a specific configuration.
    init(environment: EnvironmentProtocol, networkSession: NetworkSessionProtocol)

    /// Executes a request.
    /// - Parameters:
    ///   - request: Instance conforming to `RequestProtocol`
    ///   - completion: Completion handler.
    func execute(request: RequestProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionTask?
}
