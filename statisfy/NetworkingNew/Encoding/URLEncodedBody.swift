//
//  URLEncodedBody.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-15.
//

import Foundation

public struct URLBodyEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        var paramString = ""
        var index = 0
        for (key, value) in parameters {
            let tempString = "\(key)=\(value)"
            paramString.append(tempString)
            if index != 0 {
                paramString.append("&")
            }
            index += 1
        }
        let stringData = paramString.data(using: .utf8)
        urlRequest.httpBody = stringData
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        
    }
}
