//
//  Track.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-30.
//

import Foundation

struct TrackItem: Codable {
    let items: [Track]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Track: Codable {
    
    let album: Album?
    let artists: [Artists]?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case album
        case artists
        case name
    }
}

struct Album: Codable {
    
    let albumType: String?
    let artists: [Artists]?
    let images: [Images]?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case images
        case name
    }
}

struct Artists: Codable {
    
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
