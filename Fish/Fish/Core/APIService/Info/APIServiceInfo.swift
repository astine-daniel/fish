import Common
import Foundation

struct APIServiceInfo {
    private init() { }
}

extension APIServiceInfo {
    static var `default`: APIServiceInfo { APIServiceInfo() }
}

extension APIServiceInfo: APIServiceInfoProtocol {
    var baseURL: URLConvertible { "https://gist.githubusercontent.com/insidegui" }
}
