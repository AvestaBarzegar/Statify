//
//  TrackManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-03.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authError = "You need to be authenticated first."
    case badRequest = "Bad Request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "Could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    
    private let router = Router<TrackAPI>()
    

    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getTracks(timeRange: TimeRange, completion: @escaping (_ tracks: TileInformationArray?, _ error: String?) -> Void) {
        router.request(.artist(timeRange: timeRange)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let tracks = try decoder.decode(TrackItem.self, from: responseData)
//                        self.shortTracks = TileInformationArray(tracks: tracks)
                        let tracksViewModel = TileInformationArray(tracks: tracks)
                        completion(tracksViewModel, nil)
                        
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
}
