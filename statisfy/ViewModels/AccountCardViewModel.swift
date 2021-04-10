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
    
    init(cardModel: AccountInfoItemModel) {
        self.email = cardModel.accountInfo?.email
        self.name = cardModel.accountInfo?.displayName
        self.followerCount = cardModel.accountInfo?.followers?.total
        self.imageURL = cardModel.accountInfo?.images?[0].url
    }
}
