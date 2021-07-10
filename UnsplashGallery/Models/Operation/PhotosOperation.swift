//
//  PhotosOperation.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 30/05/21.
//

import Foundation

final class PhotosOperation: AsyncOperation {
    
    private var business: PhotosBusinessProtocol?
    var page: Int
    var response: PhotosResponse?
    
    init(page: Int, _ business: PhotosBusinessProtocol?) {
        self.business = business
        self.page = page
    }
    
    override func main() {
        super.main()
        
        self.business?.fetchPhotos(page: page, completion: { (response) in
            self.response = response
            self.finish()
        })
    }
}
