protocol OffersRepositoryProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func fetchCityOffers(_ completion: @escaping Completion<[Model.Offer]>)
    func fetchProducts(_ completion: @escaping Completion<[Model.Offer]>)
    func fetchTrips(_ completion: @escaping Completion<[Model.Offer]>)
}
