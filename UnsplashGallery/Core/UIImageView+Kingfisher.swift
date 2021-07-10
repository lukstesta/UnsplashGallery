//
//  UIImageView+Kingfisher.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 04/07/21.
//

import Kingfisher
import UIKit

/// Typealias to pattern async image completion handler
public typealias AsyncImageCompletionHandler = (Result<UIImage, Error>) -> Void

/// Extension to wrap/facade Kingfisher usage
public extension UIImageView {
    
    /// Downloads an image from a given URL and sets it to `UIImageView`
    /// - Parameters:
    ///   - url: The image URL
    ///   - placeholder: An optional placeholder to be shown while the downloads is running
    ///   - size: Placeholder size
    ///   - completionHandler: An optional `AsyncImageCompletionHandler` handler
    func setAsyncImage(from url: URL, with placeholder: UIImage? = nil, size: CGSize? = nil, completionHandler: AsyncImageCompletionHandler? = nil) {
        let fadeDuration: TimeInterval = 1
        let options: KingfisherOptionsInfo = [.scaleFactor(UIScreen.main.scale), .transition(.fade(fadeDuration)), .cacheOriginalImage]
        let handler: (Result<RetrieveImageResult, KingfisherError>) -> Void = { result in
            switch result {
            case .success(let image):
                completionHandler?(.success(image.image))
            case .failure:
                print(result)
                completionHandler?(.failure(NetworkError.invalidData))
            }
        }
        
        kf.setImage(with: url, placeholder: placeholder, options: options, completionHandler: handler)
    }
}
