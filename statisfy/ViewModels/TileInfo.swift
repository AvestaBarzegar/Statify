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
//        self.imgURL = artist.images?[0].url
        var last: Images = Images(height: -1, url: "", width: -1)
        if let images = artist.images {
            for (index, image) in images.enumerated() {
                if let width = image.width {
                    if width < 200 && index != 0 {
                        break
                    }
                }
                last = image
            }
        }
        self.imgURL = last.url
    }
    
    init(track: Track, index: Int) {
        self.title = track.name
        self.position = index
        var last: Images = Images(height: -1, url: "", width: -1)
        if let images = track.album?.images {
            for (index, image) in images.enumerated() {
                if let width = image.width {
                    if width < 200 && index != 0 {
                        break
                    }
                }
                last = image
            }
        }
        self.imgURL = last.url
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
    
    init(tracks: TrackItem) {
        var tiles: [TileInfo] = []
        
        for (index, track) in tracks.items.enumerated() {
            let tile = TileInfo(track: track, index: index + 1)
            tiles.append(tile)
        }
        self.allInfo = tiles
    }
}
