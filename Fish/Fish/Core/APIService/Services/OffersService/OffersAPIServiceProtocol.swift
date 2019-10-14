protocol OffersAPIServiceProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func fetchCityOffers(_ completion: @escaping Completion<ResponseModel>)
    func fetchTrips(_ completion: @escaping Completion<ResponseModel>)
    func fetchProducts(_ completion: @escaping Completion<ResponseModel>)
}
