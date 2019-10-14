// swiftlint:disable:this file_name

import Foundation

extension Model {
    struct Offer {
        let title: String
        let shortTitle: String?
        let fullPrice: Decimal
        let salePrice: Decimal
        let imageURL: URL?
    }
}
