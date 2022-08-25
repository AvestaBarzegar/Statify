//
//  TopTracksDataRetriever.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-01-07.
//

import Foundation
import UIKit

//struct TopTracksDataRetriever: DataRetriever {
//    typealias DataType = [[TileInfo]]
//
//    let parentViewController: UIViewController
//
//    func get() -> DataType? {
//
//        return nil
//    }
//}
//
//extension TopTracksDataRetriever {
//
//
//    init(parentViewController: UIViewController) {
//        self.parentViewController = parentViewController
//    }
//
//    private func getInformation() {
//        let controllerName = ViewControllerNames.topTracks.rawValue
//        if let expiryDate = UserDefaults.standard.object(forKey: controllerName) as? Date {
//            let currentTime = Date().timeIntervalSince1970
//            let expiryTime = expiryDate.timeIntervalSince1970
//            if currentTime >= expiryTime {
//                fetchInfo()
//            }
//        } else {
//            let oneHour: TimeInterval = 3600
//            let newExpiryDate = Date().addingTimeInterval(TimeInterval(oneHour))
//            UserDefaults.standard.setValue(newExpiryDate, forKey: controllerName)
//            fetchInfo()
//        }
//    }
//
//    private func fetchInfo() {
//
//        if AuthManager.shared.shouldRefreshToken {
//            UserManager.shared.refreshAccessToken { _, error in
//                if error != nil {
//                    print("error")
//                } else {
//                    print("refresh token TrackVC")
//                    self.fetchServerInfo()
//
//                }
//            }
//        } else {
//            fetchServerInfo()
//        }
//    }
//
//    private func fetchServerInfo() -> [[TileInfo]] {
//        let manager = AnalyticsManager()
//
//        // Fetching top tracks in the past 4 weeks
//        manager.getTracks(timeRange: .shortTerm) { short, error in
//            let indexPath = [IndexPath(row: 0, section: 0)]
//            if error == nil {
//                DispatchQueue.main.async {
//                    self?.information[0] = short
//                    self?.collectionView.reloadItems(at: indexPath)
//                }
//            } else {
//                if let error = error {
//                    DispatchQueue.main.async {
//                        CustomAlertViewController.showAlertOn(self!, "ERROR", error, "Retry", cancelButtonText: "cancel") {
//                            self?.fetchServerInfo()
//                        } cancelAction: {
//
//                        }
//                    }
//                }
//            }
//        }
//
//        // Fetching top tracks in the past 6 months
//        manager.getTracks(timeRange: .mediumTerm) { medium, error in
//            let indexPath = [IndexPath(row: 1, section: 0)]
//            if error == nil {
//                DispatchQueue.main.async {
//                    self?.information[1] = medium
//                    self?.collectionView.reloadItems(at: indexPath)
//                }
//            } else {
//                if let error = error {
//                    DispatchQueue.main.async {
//                        CustomAlertViewController.showAlertOn(self, "ERROR", error, "Retry", cancelButtonText: "cancel") {
//                            self?.fetchServerInfo()
//                        } cancelAction: {
//
//                        }
//                    }
//                }
//            }
//        }
//        
//        // Fetching top tracks of all time
//        manager.getTracks(timeRange: .longTerm) { [weak self] long, error in
//            let indexPath = [IndexPath(row: 2, section: 0)]
//            if error == nil {
//                DispatchQueue.main.async {
//                    self?.information[2] = long
//                    self?.collectionView.reloadItems(at: indexPath)
//                }
//            } else {
//                if let error = error {
//                    DispatchQueue.main.async {
//                        CustomAlertViewController.showAlertOn(self!, "ERROR", error, "Retry", cancelButtonText: "cancel") {
//                            self?.fetchServerInfo()
//                        } cancelAction: {
//
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
