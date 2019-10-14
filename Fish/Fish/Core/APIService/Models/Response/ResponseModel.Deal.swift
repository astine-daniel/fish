import Foundation

extension ResponseModel {
    struct Deal {
        // MARK: - Properties
        let title: String
        let shortTitle: String
        let fullPrice: Decimal
        let salePrice: Decimal
        let imageURLString: String
    }
}

// MARK: - Decodable extension
extension ResponseModel.Deal: Decodable { }

// MARK: - Private extension
private extension ResponseModel.Deal {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case shortTitle = "short_title"
        case fullPrice = "full_price"
        case salePrice = "sale_price"
        case imageURLString = "dealImage"
    }
}
