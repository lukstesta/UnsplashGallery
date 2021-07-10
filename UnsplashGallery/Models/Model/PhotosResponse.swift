//
//  PhotosResponse.swift
//  UnsplashGallery
//
//  Created by Lucas Mariano Testa on 30/05/21.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id: String
    let photoDescription: String?
    let altDescription: String
    let urls: Urls
    let links: PhotoLinks
    let likes: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case photoDescription = "description"
        case altDescription = "alt_description"
        case urls, links, likes, user
    }
}

// MARK: - PhotoLinks
struct PhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: - User
struct User: Codable {
    let id: String
    let updatedAt: String
    let username, name, firstName: String
    let lastName: String?
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
    }
}

typealias PhotosResponse = [Photo]
