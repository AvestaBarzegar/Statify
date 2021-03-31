//
//  RecentTrackInfo.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-27.
//

import Foundation

struct RecentTrackInfo {
    
    let artist: String?
    // To-do: Change position to let constant <3
    let track: String?
    let imgURL: String?
    
    init(artist: String?, track: String?, imgURL: String?) {
        self.artist = artist
        self.track = track
        self.imgURL = imgURL
    }
}
