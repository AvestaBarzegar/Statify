//
//  ArtistManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-29.
//

import Foundation

final class ArtistManager {
    
    static let shared = ArtistManager()
    
    var shortArtists: TileInformationArray?
    var mediumArtists: ArtistItem?
    var longArtists: ArtistItem?
    
    private init() {}
    
    func getShortArtists(with token: String, completion: @escaping (Bool) -> Void) {
        guard let url = ArtistShortEndpoint.shared.urlBuilder() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = ArtistShortEndpoint.shared.method
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
                self.shortArtists = TileInformationArray(artists: artists)
                completion(true)
            } catch {
                print("CATCH: ", error)
                completion(false)
            }
            
        }.resume()
        
    }
    
    func getMediumArtists(with token: String, completion: @escaping (Bool) -> Void) {
        guard let url = ArtistMediumEndpoint.shared.urlBuilder() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = ArtistMediumEndpoint.shared.method
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
                self.mediumArtists = artists
                print(artists)
                completion(true)
            } catch {
                print("CATCH: ", error)
                completion(false)
            }
            
        }
        
    }
    
    func getLongArtists(with token: String, completion: @escaping (Bool?) -> Void) {
        guard let url = ArtistLongEndpoint.shared.urlBuilder() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = ArtistLongEndpoint.shared.method
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
                self.longArtists = artists
                print(artists)
                completion(true)
            } catch {
                print("CATCH: ", error)
                completion(false)
            }
            
        }
        
    }
}
