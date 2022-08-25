//
//  AuthScreen.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-25.
//

import Foundation
import SwiftUI
import UIKit

struct AuthScreen: UIViewControllerRepresentable {
    
    @ObservedObject var viewModel: LoginViewModel
    
    typealias UIViewControllerType = AuthViewController
    
    func makeUIViewController(context: Context) -> AuthViewController {
        return AuthViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: AuthViewController, context: Context) {}
}
