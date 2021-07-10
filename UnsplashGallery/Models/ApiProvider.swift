//
//  ApiProvider.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 30/05/21.
//

import Foundation

protocol ApiProviderProtocol {
    func fetchPhotos(page: Int, completion: @escaping ((Result<PhotosResponse, NetworkError>) -> ()))
}

final class ApiProvider: ApiProviderProtocol {
    func fetchPhotos(page: Int, completion: @escaping ((Result<PhotosResponse, NetworkError>) -> ())) {
        
        let path = "\(Configuration.config.apiURL)/photos?page=\(page)&client_id=\(Configuration.config.accessKey)"
        
        guard let url = URL(string: path) else {
            completion(.failure(.invalidName))
            return
        }
        
        let session = URLSession.shared
        
//        var headers = [String: String]()
//        headers["Authorization"] = "Client-ID \(Configuration.config.accessKey)"
//        session.configuration.httpAdditionalHeaders = headers
        
        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let lastest = try JSONDecoder().decode(PhotosResponse.self, from: data)
                completion(.success(lastest))
            } catch {
                completion(.failure(.unableToParse))
            }
        }
        task.resume()
        
    }
}
