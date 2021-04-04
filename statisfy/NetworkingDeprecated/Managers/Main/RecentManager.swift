//
//  RecentManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-30.
//

import Foundation

final class RecentManager {
    
    static let shared = RecentManager()
    
    var recentTrackInfo: [RecentTrackViewModel] = []
        
    func getRecentTracks(with token: String, completion: @escaping (Bool) -> Void) {
        guard let url = RecentlyPlayedEndpoint.shared.urlBuilder() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = RecentlyPlayedEndpoint.shared.method
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("ERROR: ", error as Any)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("NO RESPONSE")
                return
            }
            
            guard response.statusCode == 200 else {
                print("BAD RESPONSE: ", response.statusCode)
                return
            }
            
            guard let data = data else {
                print("NO DATA")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tracks = try decoder.decode(TrackItem.self, from: data)
                self.recentTrackInfo = RecentTracksViewModelArray(tracks: tracks).allInfo ?? []
                completion(true)
            } catch {
                print("CATCH: ", error)
                completion(false)
            }
            
        }.resume()
        
    }
}
