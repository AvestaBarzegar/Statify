//
//  TopItemManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-28.
//

import Foundation
import Combine
import SwiftUI

enum TopItemType: String {
    case artist = "Top Artists"
    case track  = "Top Tracks"
}

enum LoadingState {
    case error(String)
    case loading
    case valid
}

struct TopPageInfo: Hashable {
    let tiles: [TileInfo]
    let isLoading: Bool
}

/// A protocol that manages a type of TopItems, such as `aritst` or `track`
protocol TopItemTypeManager {
    var state: [TopPageInfo?] { get }
    
    var statePublisher: Published<[TopPageInfo?]>.Publisher { get }
    
    var errorState: LoadingState { get }
    
    var errorPublisher: Published<LoadingState>.Publisher { get }
    
    func fetchData()
    
    var menuBarTitles: [String] { get }
    
    var viewTitle: TopItemType { get }
}
