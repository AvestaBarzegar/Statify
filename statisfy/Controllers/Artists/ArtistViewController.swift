//
//  ArtistViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class ArtistViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Temp Data
    
    let numOfPages: CGFloat = 3
    
    private lazy var fourWeekArtists: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "Frank Ocean", position: index, imgURL: "https://i.redd.it/1x58g8jtjndx.jpg")
            tracks.append(track)
        }
        return tracks
    }()
    
    private lazy var sixMonthArtists: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "Beach House", position: index, imgURL: "https://www.wnrn.org/wp-content/uploads/2020/03/BeachHousePMVH100111.jpg")
            tracks.append(track)
        }
        return tracks
    }()
    
    private lazy var allTimeArtists: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "JPEGMAFIA", position: index, imgURL: "https://cdns-images.dzcdn.net/images/artist/66251bd5d137fb7270d66c407a6f96e2/500x500.jpg")
            tracks.append(track)
        }
        
        return tracks
    }()
    
    private lazy var tracks: [[TileInfo]] = {
        let tracks = [fourWeekArtists, sixMonthArtists, allTimeArtists]
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

extension ArtistViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
}
