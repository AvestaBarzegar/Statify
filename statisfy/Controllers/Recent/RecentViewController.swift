//
//  RecentViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class RecentViewController: UIViewController {
    
    // MARK: - Data
    
    private lazy var recentTracks: [RecentTrackViewModel] = {
        var tracks: [RecentTrackViewModel] = []
        for index in 1...50 {
            let track = RecentTrackViewModel(artist: "Pop Smoke", track: "Christopher Walking", imgURL: "https://www.rapreviews.com/wp-content/uploads/2020/02/popsmoke-woovol2.jpg")
            tracks.append(track)
        }
        return tracks
    }()
    
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
    
    private func getInformation() {
        guard let token = AuthManager.shared.accessToken else { return }
        RecentManager.shared.getRecentTracks(with: token, completion: { [weak self] completion in
            if completion == true {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                print("damn we couldn't get the recent tracks")
            }
            
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension RecentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecentManager.shared.recentTrackInfo?.allInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RecentTrackTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentTrackTableViewCell.identifier) as? RecentTrackTableViewCell else { return UITableViewCell() }
        cell.recentTrackInfo = RecentManager.shared.recentTrackInfo?.allInfo?[indexPath.row]
        return cell
        
    }
    
}
