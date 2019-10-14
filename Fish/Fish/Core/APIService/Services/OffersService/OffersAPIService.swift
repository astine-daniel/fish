import Common

struct OffersAPIService {
    // MARK: - Properties
    private let apiService: APIServiceProtocol

    // MARK: - Initialization
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
}

// MARK: - OffersAPIServiceProtocol extension
extension OffersAPIService: OffersAPIServiceProtocol {
    func fetchCityOffers(_ completion: @escaping Self.Completion<ResponseModel>) {
        apiService.request(resource: .inTheCity(), completion)
    }

    func fetchProducts(_ completion: @escaping Self.Completion<ResponseModel>) {
        apiService.request(resource: .products(), completion)
    }

    func fetchTrips(_ completion: @escaping Self.Completion<ResponseModel>) {
        apiService.request(resource: .trips(), completion)
    }
}

// MARK: - Private extension
private extension APIServiceProtocol {
    func request(resource: OffersResource, _ completion: @escaping Completion<ResponseModel>) {
        return request(resource, completion)
    }
}
