public protocol APIServiceProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func request<T>(_ resource: Resource, _ completion: @escaping Completion<T>) where T: Decodable
}
