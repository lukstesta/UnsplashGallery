//
//  File.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 25/05/21.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
