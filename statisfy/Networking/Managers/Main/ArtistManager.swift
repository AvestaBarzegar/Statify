//
//  ArtistManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-29.
//

import Foundation

final class ArtistManager: Endpoint {
    
    var scheme: Scheme.RawValue = Scheme.https.rawValue
    
    var baseURL: String = "api.spotify.com/"
    
    var path: String = "v1/me/top/artists"
    
    var pathParameters: String? = "?time_range=long_"
    
    var parameters: [URLQueryItem]?
    
    var method: Methods.RawValue? = Methods.get.rawValue
    
    func urlBuilder() -> URL? {
        let url = scheme + baseURL + path
        let urlObj = URL(string: url)
        return urlObj
    }
    
}
