import Foundation

struct OffersRepository {
    // Properties
    private let service: OffersAPIServiceProtocol

    // MARK: - Initialization
    init(service: OffersAPIServiceProtocol = OffersAPIService()) {
        self.service = service
    }
}

// MARK: - OffersRepositoryProtocol extension
extension OffersRepository: OffersRepositoryProtocol {
    func fetchCityOffers(_ completion: @escaping Completion<[Model.Offer]>) {
        service.fetchCityOffers { result in
            switch result {
            case let .success(response):
                self.handle(response: response, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchProducts(_ completion: @escaping Completion<[Model.Offer]>) {
        service.fetchProducts { result in
            switch result {
            case let .success(response):
                self.handle(response: response, isProduct: true, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchTrips(_ completion: @escaping Completion<[Model.Offer]>) {
        service.fetchTrips { result in
            switch result {
            case let .success(response):
                self.handle(response: response, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private extension
private extension OffersRepository {
    // MARK: - Helpers
    func handle(response: ResponseModel, isProduct: Bool = false, completion: @escaping Completion<[Model.Offer]>) {
        let offers = response.deals.map { transform($0, isProduct: isProduct) }
        completion(.success(offers))
    }

    func transform(_ response: ResponseModel.Deal, isProduct: Bool) -> Model.Offer {
        let title = response.title
        let shortTitle = isProduct ? nil : response.shortTitle
        let fullPrice = response.fullPrice
        let salePrice = response.salePrice
        let imageURL = URL(string: response.imageURLString)

        return Model.Offer(title: title, shortTitle: shortTitle, fullPrice: fullPrice, salePrice: salePrice, imageURL: imageURL)
    }
}
