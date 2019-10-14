import Common
import Foundation

struct OffersResource {
    // MARK: - Properties
    private (set) var baseURL: URLConvertible
    private (set) var version: String?
    private (set) var method: HTTPMethod
    private (set) var endpoint: Endpoint
    private (set) var parser: ResourceParser
}

// MARK: - Resource extension
extension OffersResource: Resource { }

// MARK: - Methods
extension OffersResource {
    static func inTheCity(info: APIServiceInfoProtocol = APIServiceInfo.default) -> OffersResource {
        // swiftlint:disable:next line_length
        let endpoint = Endpoint(path: "/2b1f747ebeb9070e33818bf857e28a84/raw/5da63767fda2ec16f4ae0718e3be4be75001fe10/florianopolis.json")
        let parser = ClosureResourceParser(OffersResource.parser)

        return OffersResource(baseURL: info.baseURL, endpoint: endpoint, parser: parser)
    }

    static func products(info: APIServiceInfoProtocol = APIServiceInfo.default) -> OffersResource {
        // swiftlint:disable:next line_length
        let endpoint = Endpoint(path: "/007fd6664650391dca199e6784d1f351/raw/862d701c69307f9e9053f8cb1ec438586fca4b64/produtos.json")
        let parser = ClosureResourceParser(OffersResource.parser)

        return OffersResource(baseURL: info.baseURL, endpoint: endpoint, parser: parser)
    }

    static func trips(info: APIServiceInfoProtocol = APIServiceInfo.default) -> OffersResource {
        // swiftlint:disable:next line_length
        let endpoint = Endpoint(path: "/d2665b556f2be1b1ad3a19d2ef9bcc44/raw/afe1e0a9563e3bcddc3796b22becb8f12f82ee2e/viagens.json")
        let parser = ClosureResourceParser(OffersResource.parser)

        return OffersResource(baseURL: info.baseURL, endpoint: endpoint, parser: parser)
    }
}

// MARK: - Private extension
private extension OffersResource {
    // MARK: - Initialization
    init(baseURL: URLConvertible, version: String? = nil, endpoint: Endpoint, method: HTTPMethod = .get, parser: ResourceParser) {
        self.baseURL = baseURL
        self.version = version
        self.endpoint = endpoint
        self.method = method
        self.parser = parser
    }

    static func parser(data: Data?) throws -> ResponseModel {
        guard let data = data else {
            return ResponseModel(deals: [])
        }

        let decoder = JSONDecoder()
        return try decoder.decode(ResponseModel.self, from: data)
    }
}
