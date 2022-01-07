//
//  Artists.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-15.
//

import Foundation

final class MockManager {
    
    static let shared = MockManager()
    
    func fetchTopArtistsMock(timeRange: TimeRange, completion: @escaping(_ items: [TileInfo]?) -> Void) {
        var fileName = ""
        switch timeRange {
        case .shortTerm:
            fileName = "ShortArtists.json"
        case .mediumTerm:
            fileName = "MediumArtists.json"
        case .longTerm:
            fileName = "LongArtists.json"
        }
        
        let artists = Bundle.main.decode(ArtistItem.self, from: fileName)
        let artistsViewModel = TileInfo.generateArrayOfTileInfo(from: artists)
        completion(artistsViewModel)
    }
    
    func fetchTopTracksMock(timeRange: TimeRange, completion: @escaping(_ items: [TileInfo]?) -> Void) {
        var fileName = ""
        switch timeRange {
        case .shortTerm:
            fileName = "ShortTracks.json"
        case .mediumTerm:
            fileName = "MediumTracks.json"
        case .longTerm:
            fileName = "LongTracks.json"
        }
        
        let tracks = Bundle.main.decode(TrackItem.self, from: fileName)
        let tracksViewModel = TileInfo.generateArrayOfTileInfo(from: tracks)
        completion(tracksViewModel)
    }
    
    func fetchRecentTracksMock(completion: @escaping(_ items: [RecentTrackViewModel]?) -> Void) {
        let fileName = "RecentTracks.json"
        
        let recentTracks = Bundle.main.decode(RecentItemsArr.self, from: fileName)
        let tracksViewModel = RecentTrackViewModel.generateRecentTrackArray(from: recentTracks)
        completion(tracksViewModel)
    }
    
    func fetchAccountInfo(completion: @escaping(_ items: AccountCardViewModel?) -> Void) {
        let fileName = "Settings.json"
        
        let accountInfo = Bundle.main.decode(AccountInfoModel.self, from: fileName)
        let accountViewModel = AccountCardViewModel(accountInfo: accountInfo)
        completion(accountViewModel)
    }
    
}
