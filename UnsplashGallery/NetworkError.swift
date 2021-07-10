//
//  NetworkErrror.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 30/05/21.
//

import Foundation

enum NetworkError: Error {
    case invalidName
    case invalidResponse
    case invalidData
    case unableToComplete
    case unableToParse
}
