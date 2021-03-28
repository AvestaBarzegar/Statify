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
        debugPrint("Wow, someone wanted to get started!")
        // To-do: put logic for showing webView when button is tapped
//        let window = self.view.window
//        window?.rootViewController = AppTabBarController()
        self.present(AuthViewController(), animated: true, completion: nil)
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
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -48),
            subHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            subHeaderLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            subHeaderLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            
            getStartedButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -36),
            getStartedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36),
            getStartedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36),
            getStartedButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}
