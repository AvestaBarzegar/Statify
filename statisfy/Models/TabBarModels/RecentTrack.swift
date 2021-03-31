//
//  RecentTrack.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-30.
//

import Foundation

struct RecentTrackItem: Codable {
    let items: [RecentTrack]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct
