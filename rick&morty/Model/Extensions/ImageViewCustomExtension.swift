import UIKit
import Kingfisher

extension UIImageView {
  func loadImage(url: String?, beforeLoad:(() -> Void)? = nil, onSuccess:(() -> Void)? = nil, onFailure:(() -> Void)? = nil) {
    guard let path = url,
          let imageUrl = URL(string: path) else {
            onFailure?()
               return
    }
    beforeLoad?()
    KF.url(imageUrl).onFailure {
      _ in
      onFailure?()
    }.onSuccess {
      _ in
      onSuccess?()
    }.set(to: self)
  }
}
