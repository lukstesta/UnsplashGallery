//
//  HomeViewModel.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 26/05/21.
//

import UIKit

struct PhotosModel {
    let id: String
    let title: String
    let author: String
    let url: String
}

protocol HomeViewModelProtocol {
    var page: Int? { get set }
    
    var photosModel: Dynamic<[PhotosModel]> { get set }
    
    func loadList(page: Int)
}

class HomeViewModel: HomeViewModelProtocol {
    
    var page: Int?
    
    var photosModel = Dynamic<[PhotosModel]>([])
    
    private var manager: PhotosManagerProtocol?
    
    init(_ page: Int, manager: PhotosManagerProtocol = PhotosManager()) {
        self.page = page
        self.manager = manager
    }
    
    func loadList(page: Int) {
        manager?.getPhotos(page: page, completion: { response in
            if let data = response {
                self.photosModel.value = data.map {
                    PhotosModel(
                        id: $0.id,
                        title: $0.photoDescription ?? String(),
                        author: $0.user.name,
                        url: $0.urls.full
                    )
                }
            }
        })
    }
    
}
