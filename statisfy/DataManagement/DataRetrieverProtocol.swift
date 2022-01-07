//
//  DataRetriever.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-01-07.
//

import Foundation

// Make each view be injected with the model

protocol DataRetriever {
    associatedtype DataType
    
    func get() -> DataType?
}

struct TopArtistDataRetreiver: DataRetriever {
    typealias DataType = [[TileInfo]]
    
    func get() -> DataType? {
        
        return nil
    }
}

struct RecentTracksDataRetriever: DataRetriever {
    typealias DataType = [[RecentTrackViewModel]]
    
    func get() -> DataType? {
        
        return nil
    }
}

struct SettingsDataRetriever: DataRetriever {
    typealias DataType = AccountCardViewModel
    
    func get() -> DataType? {
        
        return nil
    }
    
}
