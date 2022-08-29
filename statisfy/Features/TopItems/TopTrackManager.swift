//
//  TopTrackManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-28.
//

import Combine
import SwiftUI
import Foundation

final class TopTrackManager: TopItemTypeManager {
    
    private let manager = AnalyticsManager()
    
    @Published var state: [TopPageInfo?] = [ nil, nil, nil ]
    
    var statePublisher: Published<[TopPageInfo?]>.Publisher { return $state }
    
    @Published var errorState: LoadingState = .loading
    
    var errorPublisher: Published<LoadingState>.Publisher { return $errorState }
    
    func fetchData() {
        getInformation()
    }
    
    var menuBarTitles: [String] = ["Last 4 Weeks", "Last 6 Months", "All Time"]
    
    var viewTitle: TopItemType { return .track }
    
}

/// TODO refactor
extension TopTrackManager {
    private func getInformation() {
        let controllerName = ViewControllerNames.topTracks.rawValue
        if let expiryDate = UserDefaults.standard.object(forKey: controllerName) as? Date {
            let currentTime = Date().timeIntervalSince1970
            let expiryTime = expiryDate.timeIntervalSince1970
            if currentTime >= expiryTime {
                fetchInfo()
            }
        } else {
            let oneHour: TimeInterval = 3600
            let newExpiryDate = Date().addingTimeInterval(TimeInterval(oneHour))
            UserDefaults.standard.setValue(newExpiryDate, forKey: controllerName)
            fetchInfo()
        }
    }
    
    private func fetchInfo() {
        if AuthManager.shared.shouldRefreshToken {
            UserManager.shared.refreshAccessToken { [weak self] _, error in
                if let err = error {
                    print("error: \(err)")
                } else {
                    print("refresh token TrackVC")
                    self?.fetchServerInfo()
                    
                }
            }
        } else {
            fetchServerInfo()
        }
    }
    
    private func fetchServerInfo() {
        let group = DispatchGroup()

        var proposedState: [[TileInfo]] = [ [], [], [] ]
        
        group.enter()
        // Fetching top tracks in the past 4 weeks
        manager.getTracks(timeRange: .shortTerm) { [weak self] short, error in
            if let err = error {
                self?.errorState = .error(err)
            } else {
                proposedState[0] = short ?? []
            }
            group.leave()
        }
        
        group.enter()
        // Fetching top tracks in the past 6 months
        manager.getTracks(timeRange: .mediumTerm) { [weak self] medium, error in
            if let err = error {
                self?.errorState = .error(err)
            } else {
                proposedState[1] = medium ?? []
            }
            group.leave()
        }
        
        group.enter()
        // Fetching top tracks of all time
        manager.getTracks(timeRange: .longTerm) { [weak self] long, error in
            if let err = error {
                self?.errorState = .error(err)
            } else {
                proposedState[2] = long ?? []
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.state = proposedState.map { TopPageInfo(tiles: $0, isLoading: false) }
        }
    }
}
