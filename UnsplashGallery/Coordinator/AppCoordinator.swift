//
//  AppCoordinator.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 25/05/21.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        childCoordinators = []
    }
    
    func start() {
        let navigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, parentCoordinator: self)
        
        homeCoordinator.start()
        
        childCoordinators.append(homeCoordinator)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    
}
