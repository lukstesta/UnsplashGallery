//
//  DetailsCoordinator.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 06/07/21.
//

import UIKit

class DetailsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    private var navigationController: UINavigationController?
    private weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator) {
        childCoordinators = []
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        
    }
    
    func start(_ model: PhotosModel) {
        let viewModel = DetailsViewModel(model)
        let detailsController = DetailsViewController.instantiate(self, viewModel)
        navigationController?.present(detailsController, animated: true)
    }
}
