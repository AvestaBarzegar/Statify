//
//  AlbumViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class TrackViewController: UIViewController {
    
    // MARK: - Temp Data
    
    var shortTracks: TileInformationArray?
    
    let numOfPages: CGFloat = 3
    
    private lazy var fourWeekTracks: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "Silver Soul", position: index, imgURL: "https://i.pinimg.com/originals/3b/22/21/3b22217a65c57f568ca8da56cee2efdf.jpg")
            tracks.append(track)
        }
        return tracks
    }()
    
    private lazy var sixMonthTracks: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "Chanel", position: index, imgURL: "https://upload.wikimedia.org/wikipedia/en/7/7c/Frank_Ocean_Chanel_Cover.jpg")
            tracks.append(track)
        }
        return tracks
    }()
    
    private lazy var allTimeTracks: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "Space Song", position: index, imgURL: "https://upload.wikimedia.org/wikipedia/en/thumb/0/00/Beach_House_-_Depression_Cherry.png/220px-Beach_House_-_Depression_Cherry.png")
            tracks.append(track)
        }
        return tracks
    }()
    
    private lazy var tracks: [[TileInfo]] = {
        let tracks = [fourWeekTracks, sixMonthTracks, allTimeTracks]
        return tracks
    }()
    
    let headerInfo = SectionHeaderViewModel(title: "Top Tracks", leftImageName: nil, rightImageName: nil)
    
    // MARK: - Init Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.collectionViewLayout = layout
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(StatisticsCollectionScrollView.self, forCellWithReuseIdentifier: StatisticsCollectionScrollView.identifier)
        view.isPagingEnabled = true
        view.backgroundColor = .backgroundColor
        return view
    }()

    private lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.menuBarItemTitles = ["Last 4 Weeks", "Last 6 Months", "All Time"]
        menu.baseViewController = self
        return menu
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
                        self.collectionView.alpha = 1.0
                       },
                       completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.collectionView.alpha = 0
    }
    
    private func setup() {
        self.collectionView.alpha = 0
        self.view.addSubview(collectionView)
        self.view.addSubview(menuBar)
        self.view.addSubview(headerView)
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight.rawValue),
            
            menuBar.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            menuBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: MenuBarItem.menuHeight),
            
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func getInformation() {
        guard let token = AuthManager.shared.accessToken else { return }
//        TrackManager.shared.getShortTracks(with: token, completion: { completion in
//            DispatchQueue.main.async {
//                if completion == true {
//                    print("Short Tracks were a success")
//                } else {
//                    print("damn couldn't get the short artists")
//                }
//            }
//        })
        let manager = NetworkManager()
        manager.getTracks(timeRange: .shortTerm) { [weak self] short, error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.shortTracks = short
                    let indexPath = IndexPath(item: 0, section: 0)
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            } else {
                print(error)
            }
        }
        
        TrackManager.shared.getMediumTracks(with: token, completion: { completion in
            DispatchQueue.main.async {
                if completion == true {
                    print("Medium Tracks were a success")
                } else {
                    print("damn couldn't get the medium artists")
                }
            }
        })
        
        TrackManager.shared.getLongTracks(with: token, completion: { [ weak self] completion in
            DispatchQueue.main.async {
                if completion == true {
                    self?.collectionView.reloadData()
                    print("long Tracks were a success")
                } else {
                    print("damn couldn't get the long artists")
                }
            }
        })
        self.collectionView.reloadData()
    }
    
    func menuScrollItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

    // MARK: - UICollectionView Methods

extension TrackViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticsCollectionScrollView.identifier, for: indexPath) as? StatisticsCollectionScrollView
        if indexPath.row == 0 {
            cell?.tracks = shortTracks?.allInfo
        } else if indexPath.row == 1 {
            cell?.tracks = TrackManager.shared.mediumTracks?.allInfo
        } else {
            cell?.tracks = TrackManager.shared.longTracks?.allInfo
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        menuBar.oldIndex = menuBar.currentIndex
        menuBar.currentIndex = Int(targetContentOffset.pointee.x / view.frame.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.sliderViewLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
}
