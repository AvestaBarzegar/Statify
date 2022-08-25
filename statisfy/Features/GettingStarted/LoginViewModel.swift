//
//  LoginViewModel.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-25.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    enum LoginStatus {
        case success
        case failed
        case noattempt
        case inprogress
    }
    
    var accessToken: String?
    var loginStatus: LoginStatus = .inprogress {
        didSet {
            // Note(avesta): sheet is true if we are trying to login
            let showSheetNewVal = loginStatus == .inprogress
            if showSheetNewVal != showSheet {
                showSheet = showSheetNewVal
            }
            let loginSuccessNewVal = loginStatus == .success
            if loginSuccessNewVal != loginSuccess {
                loginSuccess = loginSuccessNewVal
            }
        }
    }
    
    @Published var showSheet: Bool = false
    @Published var loginSuccess: Bool = false
    
    @Published var informationType: InformationType = .server
    
}
