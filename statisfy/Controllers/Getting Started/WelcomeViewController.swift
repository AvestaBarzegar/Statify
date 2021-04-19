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
        label.text = "Tap the get started button to link your Spotify account and view your stats"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.spotifyWhite
        label.font = UIFont.tableCellFontBolded
        return label
    }()
    
    private let getStartedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.spotifyGreen
        button.layer.cornerRadius = Constants.cornerRadius.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.textColor = UIColor.spotifyWhite
        button.titleLabel?.font = UIFont.tableCellFontBolded
        button.addTarget(self, action: #selector(getStartedClicked), for: .touchUpInside)
        return button
    }()
    
    private let demoButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Demo the app", for: .normal)
        button.titleLabel?.textColor = UIColor.spotifyWhite
        button.titleLabel?.font = UIFont.bodyFontBolded
        button.addTarget(self, action: #selector(demoButtonClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions and Navigation
    
    @objc
    func getStartedClicked() {
        AppTabBarController.informationType = .server
        let vc = AuthViewController()
        vc.modalPresentationStyle = .currentContext
        vc.completionHandler = { [weak vc, weak self] success in
            DispatchQueue.main.async {
                vc?.dismiss(animated: true, completion: nil)
                self?.handleSignIn(success: success)
            }
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc
    func demoButtonClicked() {
        AppTabBarController.informationType = .demo
        let mainTabBarVC = AppTabBarController()
        weak var window = self.view.window
        window?.rootViewController = mainTabBarVC
    }
    
    private func handleSignIn(success: Bool) {
        // to-do: yell at user on error
        guard success else { return }
        
        let mainTabBarVC = AppTabBarController()
        mainTabBarVC.modalPresentationStyle = .fullScreen
        self.present(mainTabBarVC, animated: false, completion: nil)
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
        self.view.addSubview(demoButton)
        let safeArea = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -48),
            subHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            subHeaderLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            subHeaderLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            
            getStartedButton.bottomAnchor.constraint(equalTo: demoButton.topAnchor, constant: -18),
            getStartedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36),
            getStartedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36),
            getStartedButton.heightAnchor.constraint(equalToConstant: 48),
            
            demoButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -36),
            demoButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 72),
            demoButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -72),
            demoButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    deinit {
        print("deinitialized WelcomeVC")
    }

}
