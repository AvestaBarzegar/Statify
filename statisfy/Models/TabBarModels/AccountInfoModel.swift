//
//  AccountInfoModel.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-10.
//

import Foundation

struct AccountInfoModel: Codable {

    let displayName: String?
    let email: String?
    
    let followers: Followers?
    let images: [Images]?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case email
        case followers
        case images
    }
}

struct Followers: Codable {
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case total
    }
}
