import Foundation

public protocol URLSessionProtocol {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest, completionHandler: @escaping Handler) -> URLSessionDataTask
}

// MARK: - URLSession extension
extension URLSession: URLSessionProtocol { }
