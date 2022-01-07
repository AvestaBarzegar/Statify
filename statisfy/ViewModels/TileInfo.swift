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
    let artist: String?
    
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
        self.artist = artist.name
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
        self.artist = track.artists?.first?.name
    }
    
    init(title: String, position: Int, imgURL: String, artist: String) {
        self.title = title
        self.position = position
        self.imgURL = imgURL
        self.artist = artist
    }
    
}

// MARK: - Extension to generate Arrays
extension TileInfo {
    
    static func generateArrayOfTileInfo(from artists: ArtistItem) -> [TileInfo] {
        var tiles: [TileInfo] = []
        
        for (index, artist) in artists.items.enumerated() {
            let tile = TileInfo(artist: artist, index: index + 1)
            tiles.append(tile)
        }
        return tiles
    }
    
    static func generateArrayOfTileInfo(from tracks: TrackItem) -> [TileInfo] {
        var tiles: [TileInfo] = []
        
        for (index, track) in tracks.items.enumerated() {
            let tile = TileInfo(track: track, index: index + 1)
            tiles.append(tile)
        }
        return tiles
    }
}
