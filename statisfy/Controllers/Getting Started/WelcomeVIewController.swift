//
//  ViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - Init views
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.spotifyWhite
        label.font = UIFont.welcomeFont
        return label
    }()
    
    private let subHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap the get started button to link your account"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.spotifyWhite
        label.font = UIFont.welcomeSubtitleFont
        return label
    }()
    
    private let getStartedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.spotifyGreen
        button.layer.cornerRadius = Constants.cornerRadius.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.textColor = UIColor.spotifyWhite
        button.titleLabel?.font = UIFont.bodyFontBolded
        button.addTarget(self, action: #selector(getStartedClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions and Navigation
    
    @objc
    func getStartedClicked() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak vc] success in
            DispatchQueue.main.async {
                vc?.dismiss(animated: true, completion: nil)
                self.handleSignIn(success: success)
            }
        }
        // To-do: put logic for showing webView when button is tapped
//        let window = self.view.window
//        window?.rootViewController = AppTabBarController()
        self.present(vc, animated: true, completion: nil)
    }
    
    private func handleSignIn(success: Bool) {
        // to-do: yell at user on error
        guard success else { return }
        
        let mainTabBarVC = AppTabBarController()
        weak var window = self.view.window
        window?.rootViewController = mainTabBarVC
    }
    
    deinit {
        print("Deinitialized Welcome View")
    }

    // MARK: - Layout views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColor
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.view.addSubview(headerLabel)
        self.view.addSubview(subHeaderLabel)
        self.view.addSubview(getStartedButton)
        let safeArea = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -48),
            subHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            subHeaderLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            subHeaderLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            
            getStartedButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -36),
            getStartedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36),
            getStartedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36),
            getStartedButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}
