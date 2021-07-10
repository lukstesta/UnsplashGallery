//
//  DetailsViewController.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 06/07/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private weak var detailsCoordinator: DetailsCoordinator?
    private var viewModel: DetailsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindValues()
    }
    
    static func instantiate(_ coordinator: DetailsCoordinator, _ viewModel: DetailsViewModelProtocol) -> DetailsViewController {
        let detailsController = DetailsViewController()
        detailsController.detailsCoordinator = coordinator
        detailsController.viewModel = viewModel
        
        return detailsController
    }
    
    override func loadView() {
        let detailsView = DetailsView()
        view = detailsView
    }
    
    private func bindValues() {
        viewModel?.model.bind({ (value) in
            if let detailsView = self.view as? DetailsView {
                detailsView.showImages(model: value)
            }
        })
    }
}
