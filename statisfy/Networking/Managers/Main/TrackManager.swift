//
//  TrackManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-29.
//

import Foundation

final class TrackManager {
    
    static let shared = TrackManager()
    
    var shortTracks: TileInformationArray?
    var mediumTracks: TileInformationArray?
    var longTracks: TileInformationArray?
    
    private init() {}
    
    func getShortTracks(with token: String, completion: @escaping (Bool) -> Void) {
        guard let url = TrackShortEndpoint.shared.urlBuilder() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = TrackShortEndpoint.shared.method
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
                let artists = try decoder.decode(ArtistItem.self, from: data)
                self.shortTracks = TileInformationArray(artists: artists)
                completion(true)
            } catch {
                print("CATCH: ", error)
                completion(false)
            }
            
        }.resume()
        
    }
    
    func getMediumTracks(with token: String, completion: @escaping (Bool) -> Void) {
        guard let url = TrackMediumEndpoint.shared.urlBuilder() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = TrackMediumEndpoint.shared.method
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
                let artists = try decoder.decode(ArtistItem.self, from: data)
                self.mediumTracks = TileInformationArray(artists: artists)
                completion(true)
            } catch {
                print("CATCH: ", error)
                completion(false)
            }
            
        }.resume()
        
    }
    
    func getLongTracks(with token: String, completion: @escaping (Bool?) -> Void) {
        guard let url = TrackLongEndpoint.shared.urlBuilder() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = TrackLongEndpoint.shared.method
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
                let artists = try decoder.decode(ArtistItem.self, from: data)
                self.longTracks = TileInformationArray(artists: artists)
                completion(true)
            } catch {
                print("CATCH: ", error)
                completion(false)
            }
            
        }.resume()
        
    }
}
