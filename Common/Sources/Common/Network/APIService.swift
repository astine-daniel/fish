import Dispatch
import Foundation

public struct APIService {
    // MARK: Type alias
    public typealias Completion<T> = (Result<T, Error>) -> Void

    // MARK: - Properties
    private let session: URLSessionProtocol
    private let queue: DispatchQueue?

    // MARK: - Initialization
    public init(session: URLSessionProtocol = URLSession.shared,
                queue: DispatchQueue? = nil) {
        self.session = session
        self.queue = queue
    }
}

// MARK: - APIServiceProtocol extension
extension APIService: APIServiceProtocol {
    public func request<T>(_ resource: Resource, _ completion: @escaping Completion<T>) where T: Decodable {
        let completion: Completion<T> = { self.dispathAsync(completion, result: $0) }

        do {
            let urlRequest = try resource.asURLRequest()
            let task = session.dataTask(with: urlRequest) { data, response, error in
                self.handle(resource: resource, data: data, response: response, error: error, completion)
            }
            task.resume()
        } catch let error as NetworkingError {
            completion(.failure(error))
        } catch {
            completion(.failure(NetworkingError.unexpected(error: error)))
        }
    }
}

// MARK: - Private extension
private extension APIService {
    func handle<T>(
        resource: Resource,
        data: Data?,
        response: URLResponse?,
        error: Error?,
        _ completion: @escaping Completion<T>) where T: Decodable {
        guard error == nil else {
            handle(error: error!, response: response, completion)
            return
        }

        guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkingError.unknown))
            return
        }

        handle(resource: resource, response: response, data: data, completion)
    }

    func handle<T>(error: Error, response: URLResponse?, _ completion: @escaping Completion<T>) where T: Decodable {
        guard response == nil else {
            completion(.failure(error))
            return
        }

        completion(.failure(error))
    }

    func handle<T>(
        resource: Resource,
        response: HTTPURLResponse,
        data: Data?,
        _ completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        guard let error = NetworkingError.error(from: response.statusCode) else {
            handle(resource: resource, data: data, completion)
            return
        }

        completion(.failure(error))
    }

    func handle<T>(resource: Resource, data: Data?, _ completion: @escaping Completion<T>) where T: Decodable {
        do {
            let response: T = try resource.parser.parse(data)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }

    func dispathAsync<T>(_ completion: @escaping Completion<T>, result: Result<T, Error>) {
        (queue ?? .main).async {
            completion(result)
        }
    }
}
