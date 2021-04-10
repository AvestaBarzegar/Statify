//
//  SettingsViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-06.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Data
    
    let headerInfo = SectionHeaderViewModel(title: "Settings", leftImageName: nil, rightImageName: nil)
    
    // MARK: - Initialize Views
    
    private lazy var headerView: SectionHeaderView = {
        let header = SectionHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.info = headerInfo
        return header
    }()
    
    private lazy var accountCardView: AccountCardView = {
        let card = AccountCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundColor
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.separatorStyle = .none
        view.isScrollEnabled = false

        view.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return view
    }()
    
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        getInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: Double(Constants.animationDuration.rawValue),
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.accountCardView.alpha = 1.0
                        self.tableView.alpha = 1.0
                       },
                       completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tableView.alpha = 0
        self.accountCardView.alpha = 0
    }
    
    private func setup() {
        self.view.addSubview(accountCardView)
        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight.rawValue),
            
            accountCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 32),
            accountCardView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            accountCardView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            accountCardView.heightAnchor.constraint(equalToConstant: 96),
            
            tableView.topAnchor.constraint(equalTo: accountCardView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

}

// MARK: - TableView Methods

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            print("Cell was wrong")
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.settingText = "Feedback"
        case 1:
            cell.settingText = "Logout"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingsTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Tapped feedback")
        case 1:
            CustomAlertViewController.showAlertOn(self, "Logout", "Are you sure you want to log out?", "Log me out", cancelButtonText: "Cancel") {
                UserDefaults.standard.setValue(nil, forKey: "access_token")
                UserDefaults.standard.setValue(nil, forKey: "refresh_token")
                UserDefaults.standard.setValue(nil, forKey: "expiration_date")
                let window = self.view.window
                window?.rootViewController = WelcomeViewController()
            } cancelAction: {
                print("pressed cancel")
            }
        default:
            break
        }
    }
    
}

// MARK: - Networking Logic

extension SettingsViewController {
    
    private func getInfo() {
        let manager = UserManager()
        manager.getAccountInfo { [weak self] accountInfo, error in
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self?.accountCardView.cardInfo = accountInfo
                }
            }
        }
    }
}
