import UIKit

protocol OfferListViewProtocol: AnyObject {
    var collectionView: UICollectionView { get }

    func startLoadingIndicator()
    func stopLoadingIndicator()
}
