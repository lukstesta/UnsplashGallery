//
//  HomeViewController.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 26/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private weak var homeCoordinator: HomeCoordinator?
    private var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindValues()
        
        viewModel?.loadList(page: viewModel?.page ?? 1)
    }
    
    static func instantiate(_ coordinator: HomeCoordinator, _ viewModel: HomeViewModelProtocol) -> HomeViewController {
        let homeController = HomeViewController()
        homeController.homeCoordinator = coordinator
        homeController.viewModel = viewModel
        
        return homeController
    }
    
    override func loadView() {
        let homeView = HomeView()
        homeView.homeCoordinator = homeCoordinator
        view = homeView
    }
    
    private func bindValues() {
        viewModel?.photosModel.bind({ (value) in
            if let homeView = self.view as? HomeView {
                homeView.updatePhotoGallery(photosModel: value)
            }
        })
    }
}

extension HomeViewController: HomeViewDelegate {
    
}
