//
//  PhotosBusiness.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 30/05/21.
//

import Foundation

protocol PhotosBusinessProtocol {
    func fetchPhotos(page: Int, completion: @escaping ((PhotosResponse) -> ()))
}

final class PhotosBusiness: PhotosBusinessProtocol {
    
    private var provider: ApiProviderProtocol?
    
    init(provider: ApiProviderProtocol = ApiProvider()) {
        self.provider = provider
    }
    
    func fetchPhotos(page: Int, completion: @escaping ((PhotosResponse) -> ())) {
        provider?.fetchPhotos(page: page, completion: { (result) in
            switch result {
                case .success(let photos):
                    completion(photos)
                case .failure(_):
                    break
            }
        })
    }
}
