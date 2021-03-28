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
    
    private lazy var fourWeekTracks: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "Frank Ocean", position: index, imgURL: "https://i.redd.it/1x58g8jtjndx.jpg")
            tracks.append(track)
        }
        return tracks
    }()
    
    private lazy var sixMonthTracks: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "Beach House", position: index, imgURL: "https://www.wnrn.org/wp-content/uploads/2020/03/BeachHousePMVH100111.jpg")
            tracks.append(track)
        }
        return tracks
    }()
    
    private lazy var allTimeTracks: [TileInfo] = {
        var tracks: [TileInfo] = []
        for index in 1...50 {
            let track = TileInfo(title: "JPEGMAFIA", position: index, imgURL: "https://cdns-images.dzcdn.net/images/artist/66251bd5d137fb7270d66c407a6f96e2/500x500.jpg")
            tracks.append(track)
        }
        
        return tracks
    }()
    
    // MARK: - Init Views
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.isPagingEnabled = true
        view.backgroundColor = .backgroundColor
        return view
    }()
       
    private lazy var fourWeeksView: StatisticsCollectionScrollView = {
        let view = StatisticsCollectionScrollView()
        view.tracks = fourWeekTracks
        return view
    }()
    
    private lazy var sixMonthView: StatisticsCollectionScrollView = {
        let view = StatisticsCollectionScrollView()
        view.tracks = sixMonthTracks
        return view
    }()
    
    private lazy var allTimeView: StatisticsCollectionScrollView = {
        let view = StatisticsCollectionScrollView()
        view.tracks = allTimeTracks
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
        self.view.addSubview(scrollView)
        self.view.addSubview(menuBar)
        scrollView.addSubview(fourWeeksView)
        scrollView.addSubview(sixMonthView)
        scrollView.addSubview(allTimeView)
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: Constants.menuBarHeight.rawValue),
            
            scrollView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * numOfPages, height: scrollView.bounds.height)
        fourWeeksView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        sixMonthView.frame = CGRect(x: scrollView.bounds.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        allTimeView.frame = CGRect(x: scrollView.bounds.width * 2, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
    }

}
