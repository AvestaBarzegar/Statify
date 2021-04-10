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
        view.register(RecentTrackTableViewCell.self, forCellReuseIdentifier: RecentTrackTableViewCell.identifier)
        return view
    }()
    
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
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
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight.rawValue),
            
            accountCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            accountCardView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            accountCardView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
