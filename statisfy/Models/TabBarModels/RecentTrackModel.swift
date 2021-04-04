//
//  RecentTrack.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-30.
//

import Foundation

struct RecentItemsArr: Codable {
    let items: [RecentItem]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct RecentItem: Codable {
    let track: RecentTrack?
    let playedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case track
        case playedAt = "played_at"
    }
}

struct RecentTrack: Codable {
    let artists: [Artist]?
    let album: Album?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case artists
        case album
        case name
    }
}
