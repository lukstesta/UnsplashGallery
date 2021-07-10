//
//  HomeCoordinator.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 26/05/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    private var navigationController: UINavigationController?
    private weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator) {
        childCoordinators = []
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let viewModel = HomeViewModel(1)
        let homeController = HomeViewController.instantiate(self, viewModel)
        navigationController?.setViewControllers([homeController], animated: true)
    }
    
    func showDetails(_ model: PhotosModel) {
        guard let navigationController = navigationController else { return }
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, parentCoordinator: self)
        detailsCoordinator.start(model)
        
        childCoordinators.append(detailsCoordinator)
    }
}
