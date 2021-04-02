//
//  NetworkSession.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-01.
//

import Foundation

/// Protocol to which network session handling classes must conform to.
protocol NetworkSessionProtocol {
    /// Create  a URLSessionDataTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - completionHandler: The completion handler for the data task.
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?

    /// Create  a URLSessionDownloadTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - progressHandler: Optional `ProgressHandler` callback.
    ///   - completionHandler: The completion handler for the download task.
    func downloadTask(request: URLRequest, progressHandler: ProgressHandler?, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask?

    /// Create  a URLSessionUploadTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - fileURL: The source file `URL`.
    ///   - progressHandler: Optional `ProgressHandler` callback.
    ///   - completion: he completion handler for the upload task.
    func uploadTask(with request: URLRequest, from fileURL: URL, progressHandler: ProgressHandler?, completion: @escaping (Data?, URLResponse?, Error?)-> Void) -> URLSessionUploadTask?
}

/// Class handling the creation of URLSessionTaks and responding to URSessionDelegate callbacks.
class APINetworkSession: NSObject, URLSessionDelegate {

    /// The URLSession handing the URLSessionTaks.
    var session: URLSession!

    /// A typealias describing a progress and completion handle tuple.
    private typealias ProgressAndCompletionHandlers = (progress: ProgressHandler?, completion: ((URL?, URLResponse?, Error?) -> Void)?)

    /// Dictionary containing associations of `ProgressAndCompletionHandlers` to `URLSessionTask` instances.
    private var taskToHandlersMap: [URLSessionTask : ProgressAndCompletionHandlers] = [:]

    /// Convenience initializer.
    public override convenience init() {
        // Configure the default URLSessionConfiguration.
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        if #available(iOS 11, *) {
            sessionConfiguration.waitsForConnectivity = true
        }

        // Create a `OperationQueue` instance for scheduling the delegate calls and completion handlers.
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated

        // Call the designated initializer
        self.init(configuration: sessionConfiguration, delegateQueue: queue)
    }

    /// Designated initializer.
    /// - Parameters:
    ///   - configuration: `URLSessionConfiguration` instance.
    ///   - delegateQueue: `OperationQueue` instance for scheduling the delegate calls and completion handlers.
    public init(configuration: URLSessionConfiguration, delegateQueue: OperationQueue) {
        super.init()
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }


    /// Associates a `URLSessionTask` instance with its `ProgressAndCompletionHandlers`
    /// - Parameters:
    ///   - handlers: `ProgressAndCompletionHandlers` tuple.
    ///   - task: `URLSessionTask` instance.
    private func set(handlers: ProgressAndCompletionHandlers?, for task: URLSessionTask) {
        taskToHandlersMap[task] = handlers
    }

    /// Fetches the `ProgressAndCompletionHandlers` for a given `URLSessionTask`.
    /// - Parameter task: `URLSessionTask` instance.
    /// - Returns: `ProgressAndCompletionHandlers` optional instance.
    private func getHandlers(for task: URLSessionTask) -> ProgressAndCompletionHandlers? {
        return taskToHandlersMap[task]
    }

    deinit {
        // We have to invalidate the session becasue URLSession strongly retains its delegate. https://developer.apple.com/documentation/foundation/urlsession/1411538-invalidateandcancel
        session.invalidateAndCancel()
        session = nil
    }
}
