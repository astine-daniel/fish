struct ResponseModel {
    // MARK: - Properties
    private var response: Response?

    let deals: [ResponseModel.Deal]

    init(deals: [ResponseModel.Deal]) {
        self.response = nil
        self.deals = deals
    }
}

// MARK: - Decodable extension
extension ResponseModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.decode(Response.self, forKey: .response)

        self.init(deals: response.deals)
    }
}

// MARK: - Private extension
private extension ResponseModel {
    struct Response: Decodable {
        let deals: [ResponseModel.Deal]
    }

    enum CodingKeys: String, CodingKey {
        case response
    }
}
