//
//  LoginViewModel.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-25.
//

import Foundation

final class LoginViewModel: ObservableObject {

	@Published var showSheet: Bool = false

//    enum LoginStatus {
//		case success(accessCode: String)
//        case failed
//        case noattempt
//        case inprogress
//    }
//
//	func update(loginStatus: LoginStatus) {
//		switch loginStatus {
//		case .success:
//			<#code#>
//		case .failed:
//			<#code#>
//		case .noattempt:
//			<#code#>
//		case .inprogress:
//			<#code#>
//		}
//	}
//
//    var accessToken: String?
//    var loginStatus: LoginStatus = .inprogress {
//        didSet {
//            // Note(avesta): sheet is true if we are trying to login
//            let showSheetNewVal = loginStatus == .inprogress
//            if showSheetNewVal != showSheet {
//                showSheet = showSheetNewVal
//            }
//            let loginSuccessNewVal = loginStatus == .success
//            if loginSuccessNewVal != loginSuccess {
//                loginSuccess = loginSuccessNewVal
//            }
//        }
//    }
    
}
