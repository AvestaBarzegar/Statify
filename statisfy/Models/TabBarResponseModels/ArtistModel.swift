//
//  Artist.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-30.
//

import Foundation

struct ArtistItem: Codable {
    let items: [Artist]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Artist: Codable {
    
    let externalUrls: ExternalURL?
    let followers: Follower?
    let genres: [String]?
    let images: [Images]?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers = "followers"
        case genres = "genres"
        case images = "images"
        case name = "name"
    }
}

struct Follower: Codable {
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case total
    }
}

struct Images: Codable {
    
    let height: Int?
    let url: String
    let width: Int?
    
    enum CodingKeys: String, CodingKey {
        case height
        case url
        case width
    }
}

struct ExternalURL: Codable {
    
    let spotify: String?
    
    enum CodingKeys: String, CodingKey {
        case spotify
    }
    
}
