import Foundation
import UIKit

import Kingfisher

final class ImageView: UIImageView {
    override var image: UIImage? {
        willSet {
            guard newValue == nil else { return }
            kf.cancelDownloadTask()
        }
    }

    func load(url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
            switch result {
            case .failure:
                self.backgroundColor = .darkGray
            default:
                break
            }
        }
    }
}
