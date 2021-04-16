//
//  RecentViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class RecentViewController: UIViewController {
    
    // MARK: - Data
    
    private var informationType = AppTabBarController.informationType
    
    private var information: RecentTracksViewModelArray?
    
    let headerInfo = SectionHeaderViewModel(title: "Recently Played", leftImageName: nil, rightImageName: nil)
    
    // MARK: - Init Views

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
    
    private lazy var headerView: SectionHeaderView = {
        let header = SectionHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.info = headerInfo
        return header
    }()
    
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        getInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: Double(Constants.animationDuration.rawValue),
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.tableView.alpha = 1.0
                       },
                       completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tableView.alpha = 0
    }
    
    private func setup() {
        self.tableView.alpha = 0
        self.view.backgroundColor = UIColor.backgroundColor
        self.view.addSubview(tableView)
        self.view.addSubview(headerView)
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight.rawValue),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    deinit {
        print("deinit Recent")
    }
    
}

extension RecentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information?.allInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RecentTrackTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentTrackTableViewCell.identifier) as? RecentTrackTableViewCell else { return UITableViewCell() }
        cell.recentTrackInfo = information?.allInfo?[indexPath.row]
        
        return cell
        
    }
    
}

// MARK: - Networking Logic

extension RecentViewController {
    
    private func getInformation() {
        self.showSpinner(onView: self.view)
        switch informationType {
        case .server:
            fetchServerInfo()
        case .demo:
            fetchMockInfo()
        }
    }
    
    private func fetchServerInfo() {
        let manager = AnalyticsManager()
        
        manager.getRecent { [weak self] recentArr, error in
            if error != nil {
                if let error = error {
                    DispatchQueue.main.async {
                        CustomAlertViewController.showAlertOn(self!, "ERROR", error, "Retry", cancelButtonText: "cancel") {
                            self?.getInformation()
                        } cancelAction: {
                            
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.information = recentArr
                    self?.removeSpinner()
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func fetchMockInfo() {
        MockManager.shared.fetchRecentTracksMock { [weak self] recentArr in
            DispatchQueue.main.async {
                self?.information = recentArr
                self?.removeSpinner()
                self?.tableView.reloadData()
            }
        }
    }
}
