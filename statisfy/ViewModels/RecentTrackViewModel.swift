//
//  RecentTrackInfo.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-27.
//

import Foundation

struct RecentTrackViewModel {
    
    let artist: String?
    // To-do: Change position to let constant <3
    let track: String?
    let imgURL: String?
    
    init(artist: String?, track: String?, imgURL: String?) {
        self.artist = artist
        self.track = track
        self.imgURL = imgURL
    }
    
    init(track: Track?) {
        self.artist = track?.artists?[0].name
        self.track = track?.name
        var last: Images = Images(height: -1, url: "", width: -1)
        if let images = track?.album?.images {
            for (index, image) in images.enumerated() {
                if image.width < 200 && index != 0 {
                    break
                }
                last = image
            }
        }
        self.imgURL = last.url
    }
}

struct RecentTracksViewModelArray {
    
    let allInfo: [RecentTrackViewModel]?
    
    init(tracks: TrackItem) {
        var recentTracks: [RecentTrackViewModel] = []
        
        for track in tracks.items {
            let recentTrack = RecentTrackViewModel(track: track)
            recentTracks.append(recentTrack)
        }
        self.allInfo = recentTracks
    }
}
