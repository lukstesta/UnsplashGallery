//
//  DetailsViewModel.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 06/07/21.
//

import UIKit

protocol DetailsViewModelProtocol {
    var model: Dynamic<PhotosModel> { get set }
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    var model: Dynamic<PhotosModel>
    
    init(_ model: PhotosModel) {
        self.model = Dynamic<PhotosModel>(
            PhotosModel(id: model.id, title: model.title, author: model.author, url: model.url)
        )
    }
}
