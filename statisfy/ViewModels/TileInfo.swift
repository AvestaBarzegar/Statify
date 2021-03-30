//
//  TrackInfo.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-27.
//

import Foundation

struct TileInfo {
    
    let title: String?
    // To-do: Change position to let constant <3
    var position: Int?
    let imgURL: String?
    
    init(artist: Artist, index: Int) {
        self.title = artist.name
        self.position = index
        self.imgURL = artist.images?[0].url
    }
    
    init(title: String, position: Int, imgURL: String) {
        self.title = title
        self.position = position
        self.imgURL = imgURL
    }
    
}

struct TileInformationArray {
    
    let allInfo: [TileInfo]?
    
    init(artists: ArtistItem) {
        var tiles: [TileInfo] = []
        
        for (index, artist) in artists.items.enumerated() {
            let tile = TileInfo(artist: artist, index: index + 1)
            tiles.append(tile)
        }
        self.allInfo = tiles
    }
}
