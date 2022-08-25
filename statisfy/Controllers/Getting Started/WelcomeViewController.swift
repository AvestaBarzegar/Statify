//
//  ViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit
import SwiftUI
import Combine

class WelcomeViewController: UIViewController {
    
    // MARK: - Init views
    private lazy var welcomeScreen = UIHostingController(rootView: WelcomeScreen(viewModel: viewModel))

    let viewModel: LoginViewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Actions and Navigation
    @objc
    func demoButtonClicked() {
        AppTabBarController.informationType = .demo
        let mainTabBarVC = AppTabBarController()
        view.window?.rootViewController = mainTabBarVC
    }
    
    private func handleSignIn(success: Bool) {
        // to-do: yell at user on error
        guard success else { return }
        AppTabBarController.informationType = .server
        let mainTabBarVC = AppTabBarController()
        view.window?.rootViewController = mainTabBarVC
    }

    // MARK: - Layout views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        addChildFillToBounds(welcomeScreen)
        
        viewModel.$loginSuccess
            .sink { [weak self] in self?.handleSignIn(success: $0) }
            .store(in: &cancellables)
        
        viewModel.$informationType
            .compactMap { $0 == .demo }
            .sink { [weak self] in if $0 { self?.demoButtonClicked() } }
            .store(in: &cancellables)
        // Do any additional setup after loading the view.
    }
}
