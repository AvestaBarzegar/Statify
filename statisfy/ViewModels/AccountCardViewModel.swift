//
//  AccountCardViewModel.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-09.
//

import Foundation

struct AccountCardViewModel {
    
    let email: String?
    let name: String?
    let followerCount: Int?
    let imageURL: String?
    
    init(accountInfo: AccountInfoModel) {
        self.email = accountInfo.email
        self.name = accountInfo.displayName
        self.followerCount = accountInfo.followers?.total
        self.imageURL = accountInfo.images?[0].url
    }
}
