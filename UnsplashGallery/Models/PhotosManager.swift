//
//  PhotosManager.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 30/05/21.
//

import Foundation

protocol PhotosManagerProtocol {
    func getPhotos(page: Int, completion: @escaping (PhotosResponse?) -> ())
}

final class PhotosManager: OperationQueue, PhotosManagerProtocol {
    
    private var business: PhotosBusinessProtocol?
    private var response: PhotosResponse?
    
    init(business: PhotosBusinessProtocol = PhotosBusiness()) {
        self.business = business
    }
    
    func getPhotos(page: Int, completion: @escaping (PhotosResponse?) -> ()) {
        let photosOp = PhotosOperation(page: page, business)
        photosOp.completionBlock = {
            self.response = photosOp.response
            
            DispatchQueue.main.async {
                completion(self.response)
            }
        }
        
        addOperations([photosOp], waitUntilFinished: false)
    }
}

