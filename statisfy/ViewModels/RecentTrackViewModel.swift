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
    let timeStamp: Double?
    var numOfListens: Int?
    
    init(viewModel: RecentTrackViewModel, listens: Int?) {
        self.artist = viewModel.artist
        self.track = viewModel.track
        self.imgURL = viewModel.imgURL
        self.timeStamp = viewModel.timeStamp
        self.numOfListens = listens
    }
    
    init(artist: String?, track: String?, imgURL: String?) {
        self.artist = artist
        self.track = track
        self.imgURL = imgURL
        self.numOfListens = nil
        self.timeStamp = nil
    }
    
    init(track: Track?) {
        self.artist = track?.artists?[0].name
        self.track = track?.name
        var last: Images = Images(height: -1, url: "", width: -1)
        if let images = track?.album?.images {
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
        self.numOfListens = nil
        self.timeStamp = nil
    }
    
    init(recentItem: RecentItem?) {
        self.artist = recentItem?.track?.artists?[0].name
        self.track = recentItem?.track?.name
        var last: Images = Images(height: -1, url: "", width: -1)
        if let images = recentItem?.track?.album?.images {
            for (index, image) in images.enumerated() {
                if let width = image.width {
                    if width < 150 && index != 0 {
                        break
                    }
                }
                last = image
            }
        }
        self.imgURL = last.url
        self.numOfListens = nil
        guard let dateTimeStamp = recentItem?.playedAt else {
            self.timeStamp = nil
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: dateTimeStamp) else {
            self.timeStamp = nil
            return
        }
        
        let timeStampedDouble = date.timeIntervalSince1970
        self.timeStamp = timeStampedDouble
        
    }
}

extension RecentTrackViewModel {
    
    static func generateRecentTrackArray(from tracks: TrackItem) -> [RecentTrackViewModel] {
        var recentTracks: [RecentTrackViewModel] = []

        for track in tracks.items {
            let recentTrack = RecentTrackViewModel(track: track)
            recentTracks.append(recentTrack)
        }
        return recentTracks
    }
    
    static func generateRecentTrackArray(from items: RecentItemsArr) -> [RecentTrackViewModel] {
        var recentItems: [RecentTrackViewModel] = []

        for item in items.items {
            let recentItem = RecentTrackViewModel(recentItem: item)
            recentItems.append(recentItem)
        }
        return recentItems
    }
}
