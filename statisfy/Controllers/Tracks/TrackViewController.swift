//
//  AlbumViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class TrackViewController: UIViewController {
    
    // MARK: - Temp Data
    
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
    
    // MARK: - Layout Views

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        self.view.addSubview(collectionView)
        self.view.addSubview(menuBar)
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: MenuBarItem.menuHeight),
            
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension TrackViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticsCollectionScrollView.identifier, for: indexPath) as? StatisticsCollectionScrollView
        cell?.tracks = tracks[indexPath.row]
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
