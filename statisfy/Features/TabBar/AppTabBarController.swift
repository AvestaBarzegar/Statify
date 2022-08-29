//
//  AppDestinationController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

enum InformationType {
    
    case demo
    case server
}

class AppTabBarController: UITabBarController {
    
    // MARK: - Init Views
    
    static var informationType: InformationType = .server
    
    private lazy var tabViewControllers: [UIViewController] = {
        let trackManager = TopTrackManager()
        let firstVC = TopItemViewController(manager: trackManager)
        firstVC.tabBarItem = UITabBarItem(title: "Tracks", image: UIImage(systemName: "music.note.house"), selectedImage: UIImage(systemName: "music.note.house.fill"))
        
        let artistManager = TopArtistManager()
        let secondVC = TopItemViewController(manager: artistManager)
        secondVC.tabBarItem = UITabBarItem(title: "Artists", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        
        let thirdVC = RecentViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "Recent", image: UIImage(systemName: "clock"), selectedImage: UIImage(systemName: "clock.fill"))
        
        let fourthVC = SettingsViewController()
        fourthVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        return [firstVC, secondVC, thirdVC, fourthVC]
    }()
    
    private let spinner: ProgressView = {
        let spinner = ProgressView(colors: SpinnerColors.normal, lineWidth: 5.0)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        weak var window = self.view.window
        window?.rootViewController = self
        self.view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalTo: spinner.widthAnchor)
        ])
    }
    
    private func refreshUserExpiryDates() {
        UserDefaults.standard.setValue(nil, forKey: ViewControllerNames.recentTracks.rawValue)
        UserDefaults.standard.setValue(nil, forKey: ViewControllerNames.topArtists.rawValue)
        UserDefaults.standard.setValue(nil, forKey: ViewControllerNames.topTracks.rawValue)
    }
    
    private func setupUI() {
        spinner.isAnimating = false
        self.viewControllers = tabViewControllers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshUserExpiryDates()
        loadInformation()
    }
    
    deinit {
        print("deinit App TabBar")
    }
    
    func loadInformation() {
        spinner.isAnimating = true
        switch AppTabBarController.informationType {
        case .server:
            refreshAuth()
        case .demo:
            self.setupUI()
        }
    }
    
    func refreshAuth() {
        UserManager.shared.refreshAccessToken { [weak self] _, error in
            if error != nil {
                print("error")
            } else {
                print("refresh token")
                DispatchQueue.main.async {
                    self?.setupUI()
                }
            }
        }
    }
}
