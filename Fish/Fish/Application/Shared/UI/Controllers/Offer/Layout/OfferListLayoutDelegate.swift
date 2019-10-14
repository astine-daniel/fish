import Foundation
import UIKit

final class OfferListLayoutDelegate: NSObject {
    // MARK: - Properties
    private let margin: CGFloat = 10.0
    private let preferredItemHeight: CGFloat = 285.0
}

// MARK: - UICollectionViewDelegateFlowLayout extension
extension OfferListLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: preferredItemHeight)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        margin
    }
}
